
class CategoriaModel
  attr_wrinter :cat_cod, :cat_nome, :cat_valordiaria, :cat_kmlivrediaria, :cat_valorkmexcedente, :cat_idademinima, :cat_ativo
  def initialize(cat_cod, cat_nome, cat_valordiaria,cat_kmlivrediaria,cat_valormexcendante,cat_idademinima,cat_ativo)
    @cat_cod = cat_cod
    @cat_nome = cat_nome
    @cat_valordiaria = cat_valordiaria
    @cat_kmlivrediaria = cat_kmlivrediaria
    @cat_valormexcendante = cat_valormexcendante
    @cat_idademinima = cat_idademinima
    @cat_ativo = cat_ativo
  end

  def self.map(row)
    return CategoriaModel.new(
      row['cat_cod'],
      row['cat_nome'],
      row['cat_valordiaria'],
      row['cat_kmlivrediaria'],
      row['cat_valormexcendate'],
      row['cat_idademinima'],
      row['cat_ativo']
    )
  end
  def validation
    return 'Nome incorreto' if @cat_nome.to_s.empty?
    return 'O valor da diária está incorreta' if @cat_valordiaria.to_f.negative?
    return 'Valor da kilometragem incorreta' if @cat_kmlivrediaria.to_f.negative?
    return 'Valor incorreto da diária' if @cat_valormexcendante.to_f.negative?
    return 'Idade mínima incorreta' if @cat_idademinima.to_i.zero?

    nil
  end

end