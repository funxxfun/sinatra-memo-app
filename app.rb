# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'rack'

FILE_PATH = 'public/memos.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def get_memos(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

def set_memos(file_path, memos)
  File.open(file_path, 'w') { |f| JSON.dump(memos, f) }
end

not_found do
  erb :not_found
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = get_memos(FILE_PATH)
  erb :index
end

get '/memos/new' do
  @memo = { 'title' => '', 'content' => '' }
  erb :new
end

post '/memos' do
  @memo = {
    'title' => params[:title].to_s.strip,
    'content' => params[:content].to_s.strip
  }

  if @memo['title'].empty? || @memo['content'].empty?
    @error = 'タイトルと内容を入力して下さい'

    return erb :new
  end

  memos = get_memos(FILE_PATH)
  memo_count = memos.length
  new_memo_id = memo_count + 1
  memos[new_memo_id.to_s] = @memo
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end

get '/memos/:id' do
  memos = get_memos(FILE_PATH)
  @memo = memos[params[:id]]
  @memo['id'] = params[:id]
  erb :show
end

get '/memos/:id/edit' do
  memos = get_memos(FILE_PATH)
  @memo = memos[params[:id]]
  @memo['id'] = params[:id]
  erb :edit
end

post '/memos/:id' do
  @memo = {
    'id' => params[:id],
    'title' => params[:title],
    'content' => params[:content]
  }

  if @memo['title'].empty? || @memo['content'].empty?
    @error = 'タイトルと内容を入力して下さい'

    return erb :edit
  end

  memos = get_memos(FILE_PATH)
  memos[params[:id]] = {
    'title' => params[:title],
    'content' => params[:content]
  }
  set_memos(FILE_PATH, memos)

  redirect "/memos/#{params[:id]}"
end

post '/memos/:id/delete' do
  memos = get_memos(FILE_PATH)
  memos.delete(params[:id])
  set_memos(FILE_PATH, memos)

  redirect '/memos'
end
