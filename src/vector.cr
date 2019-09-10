struct Garnet::Math::Vector < Garnet::Math::Matrix(Float32, 2, 1)
  matrix_properties [:dx, :dy]

  def self.new(dx : Float32, dy : Float32)
    vector = new
    vector.dx = dx
    vector.dy = dy
    vector
  end

  def +(other : self)
    self.class.new(dx + other.dx, dy + other.dy)
  end

  def -(other : self)
    self.class.new(dx - other.dx, dy - other.dy)
  end

  def *(other)
    self.class.new(dx * other, dy * other)
  end

  def /(other)
    self.class.new(dx / other, dy / other)
  end

  def ==(other : self)
    dx == other.dx && dy == other.dy
  end

  def inspect(io)
    io << "Vector(dx = " << dx << ", dy = " << dy << ")"
  end
end
