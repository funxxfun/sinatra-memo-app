require 'sinatra'
require 'sinatra/reloader'

get '/memos' do
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
  # メモを保存する処理をここに書く

  redirect '/memos'
end