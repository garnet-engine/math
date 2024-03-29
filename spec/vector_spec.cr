require "spec"
require "../src/garnet-math/vector"

include Garnet::Math

describe Vector2D do
  describe "#+(other : self)" do
    it "adds" do
      vector = Vector2D.new(100f32, 200f32)
      other_vector = Vector2D.new(10f32, 20f32)

      res = vector + other_vector
      res.should be_a(Vector2D)
      res.dx.should eq(110)
      res.dy.should eq(220)
    end
  end

  describe "#-(other : self)" do
    it "subtracts" do
      vector = Vector2D.new(100f32, 200f32)
      other_vector = Vector2D.new(10f32, 20f32)

      res = vector - other_vector
      res.should be_a(Vector2D)
      res.dx.should eq(90)
      res.dy.should eq(180)
    end
  end

  describe "#-" do
    it "negates" do
      vector = Vector2D.new(100f32, 200f32)

      res = -vector
      res.should be_a(Vector2D)
      res.dx.should eq(-100)
      res.dy.should eq(-200)
    end
  end

  describe "#*(other : Float32)" do
    it "multiplies" do
      vector = Vector2D.new(100f32, 200f32)

      res = vector * 0.1
      res.should be_a(Vector2D)
      res.dx.should eq(10)
      res.dy.should eq(20)
    end
  end

  describe "#/(other : Float32)" do
    it "divides" do
      vector = Vector2D.new(100f32, 200f32)

      res = vector / 10
      res.should be_a(Vector2D)
      res.dx.should eq(10)
      res.dy.should eq(20)
    end
  end

  describe "#==(other : self)" do
    it "compares" do
      vector = Vector2D.new(100f32, 200f32)
      same = Vector2D.new(100f32, 200f32)
      different = Vector2D.new(1f32, 2f32)

      (vector == same).should eq(true)
      (vector != same).should eq(false)
      (vector == different).should eq(false)
      (vector != different).should eq(true)
    end
  end

  describe "#inspect(io)" do
    it "inspects" do
      vector = Vector2D.new(100f32, 200f32)
      vector.inspect.should eq("Garnet::Math::Vector2D(dx: 100.0, dy: 200.0)")
    end
  end
end
