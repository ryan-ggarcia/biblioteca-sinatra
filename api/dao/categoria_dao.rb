
class CategoriaDao

  def create(entity,db)
    query = "insert into tb_categoria(cat_nome,cat_valordiaria,cat_kmlivrediaria,cat_valorkmexcedente,cat_idademinima) values(?,?,?,?,?)"
    values = [entity.cat_nome,entity.cat_valordiario,entity.cat_kmlivrediaria,entity.cat_valorkmexcedente,entity.cat_idademinima]
    result = db.executa_id(query,values)
    result > 0 ? result : false
  end
  def read
    query = "select * from tb_categoria"
    rows = db.execulta_select(query)
    list = []
    rows.each do |row|
      list << CategoriaModel.map(row)
    end
    list
  end

  def update (entity,db)
    query = "update tb_categoria set cat_nome = ?, cat_valordiario = ?, cat_kmlivrediario = ?, cat_valormexcedente = ? where cat_cod = ?"
    value = [entity.cat_nome,entity.cat_valordiario,entity.cat_kmlivrediario,entity.valormexcedimentom,entity.cat_cod]
    result = db.execute(query,value)
    result > 0 ? result : false
  end
end