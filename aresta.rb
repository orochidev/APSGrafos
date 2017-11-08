class Aresta
  attr_accessor :vertice1
  attr_accessor :vertice2
  attr_accessor :grafo
  attr_accessor :peso
  def initialize(vertice, vertice2, grafo, peso: 0)
      self.grafo = grafo
      if vertice.kind_of? String
        self.vertice1 = grafo.searchVerticeByRotulo(vertice)
      else
        self.vertice1 = vertice
      end

      if vertice2.kind_of? String
        self.vertice2 = grafo.searchVerticeByRotulo(vertice2)
      else
        self.vertice2 = vertice2
      end
      self.peso = peso
  end
  def u
      vertice1
  end
  def v
    vertice2
  end
end
