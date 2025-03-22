# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'rack'
require 'pg'
require_relative 'config/database'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def find_all_memos
  result = nil
  db_connection do |connection|
    result = connection.exec('SELECT * FROM memos ORDER BY id DESC')
  end

  result.to_a
end

def find_memo(id)
  result = nil
  db_connection do |connection|
    result = connection.exec_params('SELECT * FROM memos WHERE id = $1', [id])
  end

  result.first
end

def create_memo(title, content)
  return if title.empty? || content.empty?

  db_connection do |connection|
    connection.exec_params(
      'INSERT INTO memos (title, content) VALUES ($1, $2)',
      [title, content]
    )
  end

  true
end

def update_memo(id, title, content)
  return if title.empty? || content.empty?

  db_connection do |connection|
    connection.exec_params(
      'UPDATE memos SET title = $1, content = $2 WHERE id = $3',
      [title, content, id]
      )
  end

  true
end

def delete_memo(id)
  db_connection do |connection|
    connection.exec_params('DELETE FROM memos WHERE id = $1', [id])
  end
end

not_found do
  erb :not_found
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @memos = find_all_memos
  erb :index
end

get '/memos/new' do
  @memo = { 'title' => '', 'content' => '' }
  erb :new
end

post '/memos' do
  title = params[:title].to_s.strip
  content = params[:content].to_s.strip

  if create_memo(title, content)
    redirect '/memos'
  else
    @error = 'タイトルと内容を入力して下さい'
    @memo =  { 'title' => title, 'content' => content }

    return erb :new
  end
end

get '/memos/:id' do
  @memo = find_memo(params[:id])
  erb :show
end

get '/memos/:id/edit' do
  @memo = find_memo(params[:id])
  erb :edit
end

put '/memos/:id' do
  title = params[:title].to_s.strip
  content = params[:content].to_s.strip

  if update_memo(params[:id], title, content)
    redirect "/memos/#{params[:id]}"
  else
    @error = 'タイトルと内容を入力して下さい'
    @memo = { 'id' => params[:id], 'title' => title, 'content' => content }

    return erb :edit
  end
end

delete '/memos/:id' do
  delete_memo(params[:id])
  redirect '/memos'
end
