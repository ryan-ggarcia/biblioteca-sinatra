class App < Sinatra::Base

  def initialize()
    super
    @database = Database.new
    @livro_dao = LivroDao.new
  end

  get '/livro' do
    list = @livro_dao.read(@database)
    status(200)
    {livros: list}.to_json
  end
end