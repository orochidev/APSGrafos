class Kruskal
  attr_accessor :grafo

  def initialize(grafo)
    self.grafo = grafo
  end

  def run(x)
    a = []
    vertices = grafo.vertices.map{|a| MakeSet.run(a)}
    ordenados = grafo.arestas.sort_by{|a| a.peso }
    ordenados.each do |aresta|
      u = vertices.find{|v| v[:elemento] == aresta.u }.first
      v = vertices.find{|v| v[:elemento] == aresta.v }.first
      if Find.run(u) != Find.run(v)
        a << aresta
      end
    end

  end
end
