class MakeSet
  @@id_atual = 0
  def self.run(x)
    conjunto = []
    conjunto << {id: @@id_atual++, elemento: x, pai: x, ranking:0}
    conjunto
  end
end
