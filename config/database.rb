# frozen_string_literal: true

def db_connection(&block)
  connection = PG.connect(
    host: 'localhost',
    port: 5432,
    dbname: 'memos_db'
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
