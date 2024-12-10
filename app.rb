# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'rack'

FILE_PATH = 'data/memos.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def get_memos
  File.open(FILE_PATH) { |f| JSON.parse(f.read) }
end

def set_memos(memos)
  File.open(FILE_PATH, 'w') { |f| JSON.dump(memos, f) }
end

not_found do
  erb :not_found
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = get_memos
  erb :index
end

get '/memos/new' do
  @memo = { 'title' => '', 'content' => '' }
  erb :new
end

post '/memos' do
  memo = {
    'title' => params[:title].to_s.strip,
    'content' => params[:content].to_s.strip
  }

  if memo['title'].empty? || memo['content'].empty?
    @error = 'タイトルと内容を入力して下さい'
    @memo = memo

    return erb :new
  end

  memos = get_memos
  memo_count = memos.length
  new_memo_id = memo_count + 1
  memos[new_memo_id.to_s] = memo
  set_memos(memos)

  redirect '/memos'
end

get '/memos/:id' do
  memos = get_memos
  @memo = memos[params[:id]]
  @memo['id'] = params[:id]
  erb :show
end

get '/memos/:id/edit' do
  memos = get_memos
  @memo = memos[params[:id]]
  @memo['id'] = params[:id]
  erb :edit
end

post '/memos/:id' do
  memo = {
    'id' => params[:id],
    'title' => params[:title],
    'content' => params[:content]
  }

  if memo['title'].empty? || memo['content'].empty?
    @error = 'タイトルと内容を入力して下さい'
    @memo = memo

    return erb :edit
  end

  memos = get_memos
  memos[params[:id]] = {
    'title' => params[:title],
    'content' => params[:content]
  }
  set_memos(memos)

  redirect "/memos/#{params[:id]}"
end

post '/memos/:id/delete' do
  memos = get_memos
  memos.delete(params[:id])
  set_memos(memos)

  redirect '/memos'
end
