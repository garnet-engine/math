struct Garnet::Math::Rect < Garnet::Math::Matrix(Float32, 2, 2)
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
    vector = new
    vector.x = origin.x
    vector.y = origin.y
    vector.width = size.width
    vector.height = size.height
    vector
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

  def contains?(rect : Rect)
    contains?(rect.to_origin) && contains?(rect.to_origin + rect.to_size)
  end

  def grow(size : Float32)
    Rect.new(
      Point.new(x - size, y - size),
      Size.new(width + 2 * size, height + 2 * size),
    )
  end

  def grow_y(size : Float32)
    Rect.new(
      Point.new(x, y - size),
      Size.new(width, height + 2 * size),
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

  def overlaps_with?(other : self)
    left < other.right &&
      right > other.left &&
      bottom < other.top &&
      top > other.bottom
  end

  def overlaps_on_bottom_with?(other : self)
    left < other.right &&
      right > other.left &&
      bottom < other.top &&
      bottom > other.bottom
  end

  def inspect(io)
    io << "Rect(origin = " << origin << ", size = " << size << ")"
  end
end
