
class LivroModel
  attr_accessor :liv_cod, :liv_titulo, :liv_autor, :liv_categoria, :liv_quantidade, :liv_ativo, :liv_datacadastro

  def initialize(liv_cod, liv_titulo, liv_autor, liv_categoria, liv_quantidade, liv_ativo = true, liv_datacadastro = nil)
    @liv_cod = liv_cod
    @liv_titulo = liv_titulo
    @liv_autor = liv_autor
    @liv_categoria = liv_categoria
    @liv_quantidade = liv_quantidade
    @liv_ativo = liv_ativo
    @liv_datacadastro = liv_datacadastro # preenchido automaticamente pelo banco
  end

  def self.map(row)
    LivroModel.new(
      row['liv_cod'],
      row['liv_titulo'],
      row['liv_autor'],
      row['liv_categoria'],
      row['liv_quantidade'],
      row['liv_ativo'],
      row['liv_datacadastro']
    )
  end

  def validation
    return 'Título incorreto' if @liv_titulo.to_s.strip.empty?
    return 'Autor incorreto' if @liv_autor.to_s.strip.empty?
    return 'Categoria incorreta' if @liv_categoria.to_s.strip.empty?
    return 'Quantidade incorreta' if @liv_quantidade.nil? || @liv_quantidade.to_i.negative?

    nil
  end

end
