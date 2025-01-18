# Sinatra メモアプリ

Sinatraを使用したシンプルなメモアプリケーションです。

## 前提条件

始める前に、以下のものがシステムにインストールされていることを確認してください

- Ruby
- Bundler

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

3. サーバーを起動する
   ```
   bundle exec ruby app.rb
   ```

4. ウェブブラウザを開き`http://localhost:4567/memos`にアクセスする



## 機能

- メモの一覧を表示する
- 新しいメモを作成する
- 既存メモの詳細を表示する
- 既存メモを編集する
- メモを削除する
