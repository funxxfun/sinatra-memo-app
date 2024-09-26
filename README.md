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
   git clone https://github.com/あなたのユーザー名/memo-app.git
   cd /sinatra-memo-ap
   ```

2. Gemfileをbundlerを使ってインストールします：
   ```
   bundle install
   ```

3. からの`memos.json`ファイルを作成します
   ```
   echo '{}' > public/memos.json
   ```

4. サーバーを起動します：
   ```
   bundle exec ruby app.rb
   ```

5. ウェブブラウザを開き`http://localhost:4567/memos`にアクセスします



## 機能

- メモの一覧を表示する
- 新しいメモを作成する
- 既存メモの詳細を表示する
- 既存メモを編集する
- メモを削除する

## ファイル構造

```
memo-app/
├── public/
│   ├── memos.json
│   └── style.css
├── views/
│   ├── edit.erb
│   ├── index.erb
│   ├── layout.erb
│   ├── new.erb
│   └── show.erb
├── app.rb
├── Gemfile
├── Gemfile.lock
└── README.md
```
