require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'public/memos.json'

def get_memos(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

get '/memos' do
  @memos = get_memos(FILE_PATH)
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  # new_memo = Memo.new(

  # )
  redirect '/memos'
end

get '/memos/:id' do
  erb :show
end

get '/memos/:id/edit' do
  redirect '/memos/#{memo.id}'
end

delete '/memos/:id' do
  redirect '/memos'
end