require './aresta'
require './vertice'
require 'matrix'
class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class Grafo
  attr_accessor :vertices
  attr_accessor :arestas
  attr_accessor :cores
  attr_accessor :precedentes
  attr_accessor :distacia
  attr_accessor :fila

  def initialize
    @listaAdj = {}
    self.vertices = []
    self.arestas = []
  end


  def addVertice(vertice)
    self.vertices << Vertice.new(vertice)
  end

  def addAresta(vertice1, vertice2, peso = 1)
    vertice1 = searchVerticeByRotulo(vertice1) || vertice1
    vertice2 = searchVerticeByRotulo(vertice2) || vertice2

    addVertice(vertice1) unless self.vertices.include? vertice1
    addVertice(vertice2) unless self.vertices.include? vertice2
    aresta = Aresta.new(vertice1, vertice2, self, peso: peso)
    self.arestas << aresta
  end
  def to_matriz_adjacencia
    matriz = Array.new(vertices.size){Array.new(vertices.size, 0)}
    vertices = self.vertices.sort{|v| v.rotulo.to_i}
    (0..vertices.size-1).each do |i|
      (0..vertices.size-1).each do |j|
        u = vertices[i]
        v = vertices[j]
        if u == v
          matriz[i][j] = 0
        else
          aresta = searchAresta(vertices[i], vertices[j]).first
          if aresta
            matriz[i][j] = aresta.peso
          else
            matriz[i][j] = 0
          end
        end
      end
    end
    matriz
  end
  def searchAresta(vertice1, vertice2 = nil)
    if vertice2 == nil
      aresta = self.arestas.select{|aresta| aresta.vertice1 == vertice1 || aresta.vertice2 == vertice1}
    else
      aresta = self.arestas.select{|aresta| aresta.vertice1 == vertice1 && aresta.vertice2 == vertice2}
    end

    aresta
  end
  def searchVerticeByRotulo(rotulo)
    self.vertices.find {|vertice| vertice.rotulo == rotulo}
  end

  def verticesAdjacentes(vertice)
    adj = []
    arestas.each do |aresta|
      if aresta.vertice1.equal?(vertice)
        adj << aresta.vertice2
      elsif aresta.vertice2.equal?(vertice)
        adj << aresta.vertice1
      end
    end
    adj
  end

  def buscaEmLargura(verticeInicial)
    distancia = -1
    maxDistancia = 0
    self.vertices.select {|vertice| vertice != verticeInicial}.each do |vertice|
      vertice.cor = :branco
      vertice.distancia = Float::INFINITY
      vertice.predecessor = nil
      vertice
    end

    q = Queue.new
    verticeInicial.cor = :cinza
    verticeInicial.distancia = 0
    verticeInicial.predecessor = nil
    q << verticeInicial

    while !q.empty? do
      u = q.pop
      verticesAdjacentes(u).each do |v|

        if v.cor == :branco
          v.cor = :cinza
          v.distancia = u.distancia + 1
          maxDistancia = v.distancia if v.distancia > maxDistancia
          v.predecessor = u
          q << v
        end

      end
      u.cor = :preto
    end
    maxDistancia
  end
  def ciclos?
    false
  end

end
