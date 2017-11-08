class Vertice
  attr_accessor :cor
  attr_accessor :rotulo
  attr_accessor :predecessor
  attr_accessor :distancia
  def initialize(rotulo)
    self.rotulo = rotulo
  end

  def to_s
    rotulo
  end
  def equal?(vertice)
    self.rotulo == vertice.rotulo
  end
end
