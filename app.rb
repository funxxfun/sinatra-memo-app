# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'rack'
require 'pg'

configure do
  initialize_memos_file
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

not_found do
  erb :not_found
end

def db_connection
  PG.connect(
    host: 'localhost',
    port: 5432,
    dbname: 'memos_db',
    user: 'shirasawafumi'
  )
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  connection = db_connection
  @memos = connection.exec('SELECT * FROM memos ORDER BY id')
  connection.close
  erb :index
end

get '/memos/new' do
  @memo = { title: '', content: '' }
  erb :new
end

post '/memos' do
  memo = {
    title: params[:title].to_s.strip,
    content: params[:content].to_s.strip
  }

  if memo[:title].empty? || memo[:content].empty?
    @error = 'タイトルと内容を入力して下さい'
    @memo = memo

    return erb :new
  end

  memos = get_memos
  memo_count = memos.length
  new_memo_id = memo_count + 1
  memos[new_memo_id.to_s.to_sym] = memo
  set_memos(memos)

  redirect '/memos'
end

get '/memos/:id' do
  connection = db_connection
  result = connection.exec_params('SELECT * FROM memos WHERE id = $1', [params[:id]])
  @memo = result.first
  connection.close
  erb :show
end

get '/memos/:id/edit' do
  memos = get_memos
  @memo = memos[params[:id].to_sym]
  @memo[:id] = params[:id]
  erb :edit
end

put '/memos/:id' do
  memo = {
    title: params[:title].to_s.strip,
    content: params[:content].to_s.strip
  }

  if memo[:title].empty? || memo[:content].empty?
    @error = 'タイトルと内容を入力して下さい'
    @memo = memo

    return erb :edit
  end

  memos = get_memos
  memos[params[:id].to_sym] = memo
  set_memos(memos)

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memos = get_memos
  memos.delete(params[:id].to_sym)
  set_memos(memos)

  redirect '/memos'
end
