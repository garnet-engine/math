require "./matrix"

struct Garnet::Math::Size
  include Garnet::Math::Matrix(Float32)
  
  fields :width, :height

  def self.new(width : Float32, height : Float32)
    vector = new
    vector.width = width
    vector.height = height
    vector
  end

  def +(other : Size)
    self.class.new(width + other.width, height + other.height)
  end

  def -(other : Size)
    self.class.new(width - other.width, height - other.height)
  end
end
