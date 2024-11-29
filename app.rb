# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'public/memos.json'

def get_memos(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

def set_memos(file_path, memos)
  File.open(file_path, 'w') { |f| JSON.dump(memos, f) }
end

get '/memos' do
  @memos = get_memos(FILE_PATH)
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  title = params[:title]
  content = params[:content]
  memos = get_memos(FILE_PATH)
  memo_count = memos.length
  new_memo_id = memo_count + 1
  new_memo = { 'title' => title, 'content' => content }
  memos[new_memo_id.to_s] = new_memo
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
