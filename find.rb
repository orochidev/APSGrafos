class Find
  def self.run(x)
    x[:pai] = Find.run(x[:pai]) if x[:pai] != x
    x[:pai]
  end
end
