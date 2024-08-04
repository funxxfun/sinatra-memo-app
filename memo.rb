require 'sinatra'

get '/' do
  erb :index
end

get '/memos/new' do
  erb :new
end
