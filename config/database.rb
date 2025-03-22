# frozen_string_literal: true

def db_connection(&block)
  host = ENV['DATABASE_HOST'] || 'localhost'
  port = ENV['DATABASE_PORT'] || 5432
  dbname = ENV['DATABASE_NAME'] || 'memos_db'

  connection = PG.connect(
    host: host,
    port: port,
    dbname: dbname
  )

  if block
    begin
      block.call(connection)
    ensure
      connection.close
    end
  else
    connection
  end
end
