struct Garnet::Math::Size < Garnet::Math::Matrix(Float32, 2, 1)
  matrix_properties [:width, :height]

  def self.new(width : Float32, height : Float32)
    vector = new
    vector.width = width
    vector.height = height
    vector
  end

  def +(other : self)
    self.class.new(width + other.width, height + other.height)
  end

  def -(other : self)
    self.class.new(width - other.width, height - other.height)
  end

  def ==(other : self)
    width == other.width && height == other.height
  end

  def inspect(io)
    io << "Size(width = " << width << ", height = " << height << ")"
  end
end
