require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index
end

get '/memos/new' do
  erb :new
end
