# Sinatra メモアプリ

Sinatraを使用したシンプルなメモアプリケーションです。

## 前提条件

始める前に、以下のものがシステムにインストールされていることを確認してください

- Ruby
- Bundler
- PostgreSQL


## 始め方

以下の手順に従って、ローカル環境でアプリケーションを実行してください

1. リポジトリをクローンする
   ```
   git clone https://github.com/funxxfun/sinatra-memo-app.git
   cd sinatra-memo-app
   ```

2. Gemfileをbundlerを使ってインストールする
   ```
   bundle install
   ```

3. データベースをセットアップする
```bash
# PostgreSQLに接続する
psql postgres

# データベースを作成する
CREATE DATABASE memos_db;

# 作成したデータベースに接続する
\c memos_db

# メモを保存するテーブルを作成する
CREATE TABLE memos (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL
);

# PostgreSQLを終了する
\q


4. サーバを起動する
   ```
   bundle exec ruby app.rb
   ```

5. ウェブブラウザを開き`http://localhost:4567/memos`にアクセスする



## 機能

- メモの一覧を表示する
- 新しいメモを作成する
- 既存メモの詳細を表示する
- 既存メモを編集する
- メモを削除する
