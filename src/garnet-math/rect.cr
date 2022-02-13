require "./matrix"
require "./point"
require "./size"

struct Garnet::Math::Rect
  include Garnet::Math::Matrix(Float32)
  
  fields :x, :y, :width, :height

  def self.new(x : Float32, y : Float32, width : Float32, height : Float32)
    vector = new
    vector.x = x
    vector.y = y
    vector.width = width
    vector.height = height
    vector
  end

  def self.new(origin : Point, dimensions : Size)
    new origin.x, origin.y, dimensions.width, dimensions.height
  end

  def origin
    Point.new(x, y)
  end

  def dimensions
    Size.new(width, height)
  end

  def contains?(point : Point)
    x <= point.x &&
      y <= point.y &&
      point.x <= x + width &&
      point.y <= y + height
  end

  def contains?(rect : self)
    contains?(rect.origin) && contains?(rect.origin + rect.dimensions)
  end

  def grow(dimensions : Size)
    grow dimensions.width, dimensions.height
  end

  def grow(size : Float32)
    grow size, size
  end

  def grow(grow_width : Float32, grow_height : Float32)
    self.class.new(
      x - grow_width,
      y - grow_height,
      width + 2 * grow_width,
      height + 2 * grow_height
    )
  end

  def left
    x
  end

  def right
    x + width
  end

  def bottom
    y
  end

  def top
    y + height
  end

  def intersects?(other : self)
    left < other.right &&
      right > other.left &&
      bottom < other.top &&
      top > other.bottom
  end

  def inspect(io)
    io << self.class.name << '('
    io << "origin: " << origin
    io << ", size: " << dimensions
    io << ')'
  end
end
