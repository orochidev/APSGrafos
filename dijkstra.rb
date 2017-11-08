class Dijkstra
  attr_accessor :grafo

  def initialize(grafo)
    self.grafo = grafo
  end


  def self.run(grafo, inicial)
    vetor = []

    grafo.vertices.each do |vertice|
      if vertice == inicial
        vetor << {elemento: vertice, distancia: 0, predecessor: nil, terminado: false }
      else
        vetor << {elemento: vertice, distancia: Float::INFINITY, predecessor: nil, terminado: false}
      end
    end

    while vetor.any?{|v| v[:terminado] == false} do
      u = vetor.select{|v| v[:terminado] == false}.min_by{|v| v[:distancia]}[:elemento]
      adjacentes = grafo.verticesAdjacentes(u)
      remetente = vetor.find{|e| e[:elemento] == u}
      adjacentes.each do |v|
        myself = vetor.find{|e| e[:elemento] == v}
        aresta = grafo.searchAresta(u, v).first
        if aresta && aresta.peso + remetente[:distancia]  < myself[:distancia]
          myself[:distancia] = aresta.peso + remetente[:distancia]
          myself[:predecessor] = u
        end
      end
      remetente[:terminado] = true
    end
    vetor
  end

  def self.runReverse(grafo, inicial)
    vetor = []

    grafo.vertices.each do |vertice|
      if vertice == inicial
        vetor << {elemento: vertice, distancia: Float::INFINITY, predecessor: nil, terminado: false }
      else
        vetor << {elemento: vertice, distancia: 0, predecessor: nil, terminado: false}
      end
    end

    while vetor.any?{|v| v[:terminado] == false} do
      u = vetor.select{|v| v[:terminado] == false}.min_by{|v| v[:distancia]}[:elemento]
      adjacentes = grafo.verticesAdjacentes(u)
      remetente = vetor.find{|e| e[:elemento] == u}
      adjacentes.each do |v|
        myself = vetor.find{|e| e[:elemento] == v}
        aresta = grafo.searchAresta(u, v).first
        if aresta && aresta.peso + remetente[:distancia] >= myself[:distancia]
          myself[:distancia] = aresta.peso + remetente[:distancia]
          myself[:predecessor] = u
        end
      end
      remetente[:terminado] = true
    end
    vetor


  end

  def self.vetor_to_path(vetor, vertice)
    elemento = vetor.find{|v| v[:elemento] == vertice}
    retorno = []
    while elemento[:predecessor] != nil do
      p elemento
      retorno << {elemento: elemento[:elemento], distancia: elemento[:distancia]}
      elemento = vetor.find{|v| v[:elemento] == elemento[:predecessor]}
    end
    retorno <<  {elemento: elemento[:elemento], distancia: elemento[:distancia]}
    retorno
  end
end
