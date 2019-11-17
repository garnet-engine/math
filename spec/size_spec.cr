require "spec"
require "../src/garnet-math"

include Garnet::Math

describe Size do
  describe "#+(other : self)" do
    it "adds" do
      size = Size.new(100f32, 200f32)
      other_size = Size.new(10f32, 20f32)

      res = size + other_size
      res.should be_a(Size)
      res.width.should eq(110)
      res.height.should eq(220)
    end
  end

  describe "#-(other : self)" do
    it "subtracts" do
      size = Size.new(100f32, 200f32)
      other_size = Size.new(10f32, 20f32)

      res = size - other_size
      res.should be_a(Size)
      res.width.should eq(90)
      res.height.should eq(180)
    end
  end

  describe "#-" do
    it "negates" do
      size = Size.new(100f32, 200f32)

      res = -size
      res.should be_a(Size)
      res.width.should eq(-100)
      res.height.should eq(-200)
    end
  end

  describe "#==(other : self)" do
    it "compares" do
      size = Size.new(100f32, 200f32)
      same = Size.new(100f32, 200f32)
      different = Size.new(1f32, 2f32)

      (size == same).should eq(true)
      (size != same).should eq(false)
      (size == different).should eq(false)
      (size != different).should eq(true)
    end
  end

  describe "#inspect(io)" do
    it "inspects" do
      size = Size.new(100f32, 200f32)
      size.inspect.should eq("Size(width = 100.0, height = 200.0)")
    end
  end
end
