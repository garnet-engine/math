struct Garnet::Math::Point < Garnet::Math::Matrix(Float32, 2)
  matrix_properties [:x, :y]

  def self.new(x : Float32, y : Float32)
    vector = new
    vector.x = x
    vector.y = y
    vector
  end

  def +(other : Vector)
    self.class.new(x + other.dx, y + other.dy)
  end

  def +(other : Size)
    self.class.new(x + other.width, y + other.height)
  end

  def -(other : self)
    Vector.new(x - other.x, y - other.y)
  end

  def -(other : Vector)
    self.class.new(x - other.dx, y - other.dy)
  end

  def -(other : Size)
    self.class.new(x - other.width, y - other.height)
  end

  def inspect(io)
    io << "Point(x = " << x << ", y = " << y << ")"
  end
end
