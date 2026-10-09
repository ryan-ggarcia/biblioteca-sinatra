require "mysql2"

DB = Mysql2::Client.new(
  host: '132.226.245.178',
  username: '10442519210',
  password: '10442519210',
  database: 'PFS2_10442519210',
  port: 3306,
  default_file: File.expand_path("my.cnf", __dir__),
  default_group: "client"
)
class Database
  # INSERT, UPDATE, DELETE
  def executa_comando(sql, *values)
    comando = DB.prepare(sql) # prepara o SQL com os ?
    comando.execute(*values) # preenche os ? com os valores passados, executa o SQL
    comando.affected_rows > 0 # útima linha executada pelo banco retorna (true/false)
  end

  # SELECT
  def executa_select(sql, *values)
    comando = DB.prepare(sql)
    return comando.execute.to_a if values.empty?

    # executa sem o valores

    comando.execute(*values).to_a # execulta com valores e retorna um array
  end

  # RETORNAR ID
  def executa_id(sql, *values)
    comando = DB.prepare(sql)
    comando.execute(*values)
    comando.last_id
  end
end