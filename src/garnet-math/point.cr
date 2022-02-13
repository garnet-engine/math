require "./matrix"
require "./vector"
require "./size"

struct Garnet::Math::Point
  include Garnet::Math::Matrix(Float32)
  
  fields :x, :y

  def self.new(x : Float32, y : Float32)
    vector = new
    vector.x = x
    vector.y = y
    vector
  end

  def +(other : Vector2D)
    self.class.new(x + other.dx, y + other.dy)
  end

  def +(other : Size)
    self.class.new(x + other.width, y + other.height)
  end

  def -(other : self)
    Vector2D.new(x - other.x, y - other.y)
  end

  def -(other : Vector2D)
    self.class.new(x - other.dx, y - other.dy)
  end

  def -(other : Size)
    self.class.new(x - other.width, y - other.height)
  end
end
