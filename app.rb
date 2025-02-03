# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'rack'
require 'pg'

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
  @memos = connection.exec('SELECT * FROM memos ORDER BY id DESC').to_a
  connection.close
  erb :index
end

get '/memos/new' do
  @memo = { 'title' => '', 'content' => '' }
  erb :new
end

post '/memos' do
  title = params[:title].to_s.strip
  content = params[:content].to_s.strip

  if title.empty? || content.empty?
    @error = 'タイトルと内容を入力して下さい'
    @memo =  { 'title'=> title, 'content'=> content }

    return erb :new
  end

  connection = db_connection
  connection.exec_params(
    'INSERT INTO memos (title, content) VALUES ($1, $2)',
     [title, content]
  )
  connection.close

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
  connection = db_connection
  result = connection.exec_params('SELECT * FROM memos WHERE id = $1', [params[:id]])
  @memo = result.first
connection.close
erb :edit
end

put '/memos/:id' do
  title = params[:title].to_s.strip
  content = params[:content].to_s.strip

  if title.empty? || content.empty?
    @error = 'タイトルと内容を入力して下さい'
    @memo = { 'id' => params[:id], 'title' => title, 'content' => content }

    return erb :edit
  end

  connection = db_connection
  connection.exec_params(
    'UPDATE memos SET title = $1, content = $2 WHERE id = $3',
    [title, content, params[:id]]
  )
  connection.close

  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  connection = db_connection
  connection.exec_params('DELETE FROM memos WHERE id = $1', [params[:id]])
  connection.close

  redirect '/memos'
end
