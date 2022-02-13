require "spec"
require "../src/garnet-math/matrix"

include Garnet::Math

struct TestMatrix
  include Matrix(Float32)

  fields :a1, :a2, :a3, :a4,
         :b1, :b2, :b3, :b4,
         :c1, :c2, :c3, :c4,
         :d1, :d2, :d3, :d4

  def row_size
    ::Math.sqrt(size).to_i
  end

  def column_size
    ::Math.sqrt(size).to_i
  end
end

def is_identity(matrix)
  0.upto(15) do |i|
    matrix[i].should eq(i % 5 != 0 ? 0 : 1)
  end
end

def is_ones(matrix)
  0.upto(15) do |i|
    matrix[i].should eq(1)
  end
end

describe Matrix do
  context "constructors" do
    describe ".zero" do
      it "is all zeroes" do
        matrix = TestMatrix.zero

        0.upto(15) do |v|
          matrix[v].should eq(0)
        end
      end
    end

    describe ".one" do
      it "is all ones" do
        matrix = TestMatrix.one

        0.upto(15) do |v|
          matrix[v].should eq(1)
        end
      end
    end

    describe ".identity" do
      it "builds an identity matrix" do
        matrix = TestMatrix.identity

        is_identity(matrix)
      end
    end

    describe ".new(&block)" do
      it "builds by index" do
        matrix = TestMatrix.new { |x| x.to_f32 }

        0.upto(15) do |v|
          matrix[v].should eq(v)
        end
      end
    end
  end

  context "indexing" do
    describe "#[](index)" do
      it "should find element by index" do
        matrix = TestMatrix.new { |i| i.to_f32 }

        0.upto(15) do |i|
          matrix[i].should eq(i)
        end
      end
    end

    describe "#[](row, column)" do
      it "should find element by coordinates" do
        matrix = TestMatrix.new { |i| i.to_f32 }

        0.upto(15) do |i|
          row = i % 4
          column = (i / 4).to_i
          matrix[row, column].should eq(i)
        end
      end
    end
  end

  context "comparison" do
    describe "#==(other)" do
      it "should compare equality" do
        matrix = TestMatrix.identity
        (matrix == matrix.clone).should eq(true)
      end
    end
  end

  context "mutations" do
    describe "#[]=(index, value)" do
      it "should update element by index" do
        matrix = TestMatrix.zero
        matrix[0] = 1f32
        matrix[5] = 1f32
        matrix[10] = 1f32
        matrix[15] = 1f32

        is_identity(matrix)
      end
    end

    describe "#[]=(row, column, value)" do
      it "should update element by coordinates" do
        matrix = TestMatrix.zero
        matrix[0, 0] = 1f32
        matrix[1, 1] = 1f32
        matrix[2, 2] = 1f32
        matrix[3, 3] = 1f32

        is_identity(matrix)
      end
    end

    describe "#identity!" do
      matrix = TestMatrix.new { |i| i.to_f32 }
      matrix.identity!

      0.upto(15) do |i|
        matrix[i].should eq(i % 5 != 0 ? 0 : 1)
      end
    end

    describe "#update!" do
      matrix = TestMatrix.new { |i| i.to_f32 }
      matrix.update! { |i| (i * i).to_f32 }

      0.upto(15) do |i|
        matrix[i].should eq(i * i)
      end
    end
  end

  context "immutable" do
    describe "#clone" do
      it "should clone" do
        matrix = TestMatrix.new { |i| i.to_f32 }
        clone = matrix.clone

        0.upto(15) do |v|
          clone[v].should eq(matrix[v])
        end
      end
    end
  end

  context "logging" do
    describe "#inspect" do
      it "should produce a table string" do
        ones = TestMatrix.one
        ones.inspect.should eq(
          "TestMatrix(a1: 1.0, a2: 1.0, a3: 1.0, a4: 1.0, b1: 1.0, b2: 1.0, b3: 1.0, b4: 1.0, c1: 1.0, c2: 1.0, c3: 1.0, c4: 1.0, d1: 1.0, d2: 1.0, d3: 1.0, d4: 1.0)"
        )
      end
    end
  end
end
