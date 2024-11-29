
require 'sinatra'
require 'sinatra/reloader'

get '/memos' do
  erb :index
end

get '/memos/new' do
  erb :new
end

post '/memos' do
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
