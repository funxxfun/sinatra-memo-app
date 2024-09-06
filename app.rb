require 'sinatra'
require 'sinatra/reloader'

get '/memos' do
  # @memos = Memo.all

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