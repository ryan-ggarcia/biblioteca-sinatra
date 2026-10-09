
class LivroDao

  def create(entity,db)
    query = "insert into tb_livro(liv_titulo,liv_autor,liv_categoria,liv_quantidade) values(?,?,?,?)"
    values = [entity.liv_titulo, entity.liv_autor, entity.liv_categoria, entity.liv_quantidade]
    result = db.executa_id(query, *values)
    result > 0 ? result : false
  end

  def read(db)
    query = "select * from tb_livro where liv_ativo = true"
    rows = db.executa_select(query)
    list = []
    rows.each do |row|
      list << LivroModel.map(row)
    end
    list
  end

  def find_by_id(liv_cod,db)
    query = "select * from tb_livro where liv_cod = ?"
    rows = db.executa_select(query, liv_cod)
    rows.empty? ? nil : LivroModel.map(rows.first)
  end

  def update(entity,db)
    query = "update tb_livro set liv_titulo = ?, liv_autor = ?, liv_categoria = ?, liv_quantidade = ? where liv_cod = ?"
    values = [entity.liv_titulo, entity.liv_autor, entity.liv_categoria, entity.liv_quantidade, entity.liv_cod]
    db.executa_comando(query, *values)
  end

  # exclusão lógica: só marca o livro como inativo
  def delete(liv_cod,db)
    query = "update tb_livro set liv_ativo = false where liv_cod = ?"
    db.executa_comando(query, liv_cod)
  end
end
