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