require "spec"
require "../src/garnet-math"

include Garnet::Math

describe Point do
  describe "#+(other : Vector)" do
    it "adds" do
      point = Point.new(100f32, 200f32)
      vector = Vector.new(10f32, 20f32)

      res = point + vector
      res.should be_a(Point)
      res.x.should eq(110)
      res.y.should eq(220)
    end
  end

  describe "#+(other : Size)" do
    it "adds" do
      point = Point.new(100f32, 200f32)
      size = Size.new(10f32, 20f32)

      res = point + size
      res.should be_a(Point)
      res.x.should eq(110)
      res.y.should eq(220)
    end
  end

  describe "#-(other : self)" do
    it "subtracts" do
      point = Point.new(100f32, 200f32)
      other_point = Point.new(10f32, 20f32)

      res = point - other_point
      res.should be_a(Vector)
      res.dx.should eq(90)
      res.dy.should eq(180)
    end
  end

  describe "#-(other : Vector)" do
    it "subtracts" do
      point = Point.new(100f32, 200f32)
      vector = Vector.new(10f32, 20f32)

      res = point - vector
      res.should be_a(Point)
      res.x.should eq(90)
      res.y.should eq(180)
    end
  end

  describe "#==(other : self)" do
    it "compares" do
      point = Point.new(100f32, 200f32)
      same = Point.new(100f32, 200f32)
      different = Vector.new(1f32, 2f32)

      (point == same).should eq(true)
      (point != same).should eq(false)
      (point == different).should eq(false)
      (point != different).should eq(true)
    end
  end

  describe "#inspect(io)" do
    it "inspects" do
      vector = Point.new(100f32, 200f32)
      vector.inspect.should eq("Point(x = 100.0, y = 200.0)")
    end
  end
end
