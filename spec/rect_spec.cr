require "spec"
require "../src/garnet-math"

include Garnet::Math

describe Rect do
  describe "#initialize(origin : Point, size : Size)" do
    it "has correct derived attributes" do
      origin_x = 100f32
      origin_y = 200f32
      origin = Point.new(origin_x, origin_y)
      width = 300f32
      height = 400f32
      size = Size.new(width, height)
      rect = Rect.new(origin, size)

      rect.width.should eq(width)
      rect.height.should eq(height)
      rect.left.should eq(origin_x)
      rect.right.should eq(origin_x + width)
      rect.top.should eq(origin_y + height)
      rect.bottom.should eq(origin_y)
    end
  end

  describe "#initialize(ox : Float32, oy : Float32, sx : Float32, sy : Float32)" do
    it "has correct derived attributes" do
      origin_x = 100f32
      origin_y = 200f32
      width = 300f32
      height = 400f32
      rect = Rect.new(origin_x, origin_y, width, height)

      rect.width.should eq(width)
      rect.height.should eq(height)
      rect.left.should eq(origin_x)
      rect.right.should eq(origin_x + width)
      rect.top.should eq(origin_y + height)
      rect.bottom.should eq(origin_y)
    end
  end

  describe "#grow" do
    it "grows by f32 size" do
      origin_x = 100f32
      origin_y = 200f32
      origin = Point.new(origin_x, origin_y)
      width = 300f32
      height = 400f32
      size = Size.new(width, height)
      rect = Rect.new(origin, size)

      rect = rect.grow(1f32)

      rect.left.should eq(99)
      rect.right.should eq(401)
      rect.top.should eq(601)
      rect.bottom.should eq(199)
    end

    it "grows by f32 width and height" do
      origin_x = 100f32
      origin_y = 200f32
      origin = Point.new(origin_x, origin_y)
      width = 300f32
      height = 400f32
      size = Size.new(width, height)
      rect = Rect.new(origin, size)

      rect = rect.grow(1f32, 2f32)

      rect.left.should eq(99)
      rect.right.should eq(401)
      rect.top.should eq(602)
      rect.bottom.should eq(198)
    end

    it "grows by size instance" do
      origin_x = 100f32
      origin_y = 200f32
      origin = Point.new(origin_x, origin_y)
      width = 300f32
      height = 400f32
      size = Size.new(width, height)
      rect = Rect.new(origin, size)

      grow_by = Size.new(1f32, 2f32)
      rect = rect.grow(grow_by)

      rect.left.should eq(99)
      rect.right.should eq(401)
      rect.top.should eq(602)
      rect.bottom.should eq(198)
    end
  end

  describe "#contains?(other : Point)" do
    it "is contained" do
      origin = Point.new(100f32, 200f32)
      size = Size.new(300f32, 400f32)
      rect = Rect.new(origin, size)

      rect.contains?(Point.new(101f32, 201f32)).should eq(true) # top-left
      rect.contains?(Point.new(101f32, 599f32)).should eq(true) # top-right
      rect.contains?(Point.new(399f32, 201f32)).should eq(true) # bottom-left
      rect.contains?(Point.new(399f32, 599f32)).should eq(true) # bottom-right
    end

    it "is not contained" do
      origin = Point.new(100f32, 200f32)
      size = Size.new(300f32, 400f32)
      rect = Rect.new(origin, size)

      # top-left
      rect.contains?(Point.new(99f32, 201f32)).should eq(false)
      rect.contains?(Point.new(101f32, 199f32)).should eq(false)

      # top-right
      rect.contains?(Point.new(599f32, 199f32)).should eq(false)
      rect.contains?(Point.new(601f32, 201f32)).should eq(false)

      # bottom-left
      rect.contains?(Point.new(99f32, 599f32)).should eq(false)
      rect.contains?(Point.new(101f32, 601f32)).should eq(false)

      # bottom-right
      rect.contains?(Point.new(401f32, 599f32)).should eq(false)
      rect.contains?(Point.new(399f32, 601f32)).should eq(false)
    end
  end

  describe "#contains?(other : Rect)" do
    it "is contained" do
      rect = Rect.new(100f32, 200f32, 300f32, 400f32)

      rect.contains?(Rect.new(101f32, 201f32, 298f32, 398f32)).should eq(true)
    end

    it "is not contained" do
      rect = Rect.new(100f32, 200f32, 300f32, 400f32)

      rect.contains?(Rect.new(99f32, 200f32, 300f32, 400f32)).should eq(false)
      rect.contains?(Rect.new(100f32, 199f32, 300f32, 400f32)).should eq(false)
      rect.contains?(Rect.new(100f32, 200f32, 301f32, 400f32)).should eq(false)
      rect.contains?(Rect.new(100f32, 200f32, 300f32, 401f32)).should eq(false)
    end
  end

  describe "#intersects?(other : Rect)" do
    it "is intersecting" do
      rect = Rect.new(100f32, 200f32, 300f32, 400f32)

      rect.intersects?(Rect.new(rect.x - 1f32, rect.y + 1f32, rect.width, rect.height)).should eq(true)
      rect.intersects?(Rect.new(rect.x + 1f32, rect.y + 1f32, rect.width, rect.height)).should eq(true)
      rect.intersects?(Rect.new(rect.x + 1f32, rect.y - 1f32, rect.width, rect.height)).should eq(true)
      rect.intersects?(Rect.new(rect.x - 1f32, rect.y - 1f32, rect.width, rect.height)).should eq(true)
    end

    it "is not intersecting" do
      rect = Rect.new(100f32, 200f32, 300f32, 400f32)

      rect.intersects?(Rect.new(rect.x - rect.width, rect.y + rect.height, rect.width, rect.height)).should eq(false)
      rect.intersects?(Rect.new(rect.x + rect.width, rect.y + rect.height, rect.width, rect.height)).should eq(false)
      rect.intersects?(Rect.new(rect.x + rect.width, rect.y - rect.height, rect.width, rect.height)).should eq(false)
      rect.intersects?(Rect.new(rect.x - rect.width, rect.y - rect.height, rect.width, rect.height)).should eq(false)
    end
  end

  describe "#inspect(io)" do
    it "inspects" do
      origin_x = 100f32
      origin_y = 200f32
      width = 300f32
      height = 400f32
      rect = Rect.new(origin_x, origin_y, width, height)
      rect.inspect.should eq("Rect(origin = Point(x = 100.0, y = 200.0), size = Size(width = 300.0, height = 400.0))")
    end
  end
end
