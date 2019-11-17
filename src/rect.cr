struct Garnet::Math::Rect < Garnet::Math::Matrix(Float32, 4)
  matrix_properties [:x, :y, :width, :height]

  def self.new(x : Float32, y : Float32, width : Float32, height : Float32)
    vector = new
    vector.x = x
    vector.y = y
    vector.width = width
    vector.height = height
    vector
  end

  def self.new(origin : Point, size : Size)
    new origin.x, origin.y, size.width, size.height
  end

  def to_origin
    Point.new(x, y)
  end

  def to_size
    Size.new(width, height)
  end

  def contains?(point : Point)
    x <= point.x &&
      y <= point.y &&
      point.x <= x + width &&
      point.y <= y + height
  end

  def contains?(rect : self)
    contains?(rect.to_origin) && contains?(rect.to_origin + rect.to_size)
  end

  def grow(size : Size)
    grow size.width, size.height
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
    io << "Rect(origin = " << to_origin << ", size = " << to_size << ")"
  end
end
