require "./matrix"

struct Garnet::Math::Vector2D
  include Garnet::Math::Matrix(Float32)

  fields :dx, :dy

  def self.new(dx : Float32, dy : Float32)
    vector = new
    vector.dx = dx
    vector.dy = dy
    vector
  end
end

struct Garnet::Math::Vector3D
  include Garnet::Math::Matrix(Float32)

  fields :dx, :dy, :dz

  def self.new(dx : Float32, dy : Float32, dz : Float32)
    vector = new
    vector.dx = dx
    vector.dy = dy
    vector.dz = dz
    vector
  end
end
