# frozen_string_literal: true

def db_connection
  PG.connect(
    host: 'localhost',
    port: 5432,
    dbname: 'memos_db'
  )
end
