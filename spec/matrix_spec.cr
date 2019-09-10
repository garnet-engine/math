require "spec"
require "../src/garnet-math"

include Garnet::Math

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

describe Mat4 do
  context "constructors" do
    describe ".zero" do
      it "is all zeroes" do
        matrix = Mat4.zero

        0.upto(15) do |v|
          matrix[v].should eq(0)
        end
      end
    end

    describe ".one" do
      it "is all ones" do
        matrix = Mat4.one

        0.upto(15) do |v|
          matrix[v].should eq(1)
        end
      end
    end

    describe ".identity" do
      it "builds an identity matrix" do
        matrix = Mat4.identity

        is_identity(matrix)
      end
    end

    describe ".new(&block)" do
      it "builds by index" do
        matrix = Mat4.new { |x| x.to_f32 }

        0.upto(15) do |v|
          matrix[v].should eq(v)
        end
      end
    end
  end

  context "indexing" do
    describe "#[](index)" do
      it "should find element by index" do
        matrix = Mat4.new { |i| i.to_f32 }

        0.upto(15) do |i|
          matrix[i].should eq(i)
        end
      end
    end

    describe "#[](row, column)" do
      it "should find element by coordinates" do
        matrix = Mat4.new { |i| i.to_f32 }

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
        matrix = Mat4.identity
        (matrix == matrix.clone).should eq(true)
      end
    end
  end

  context "mutations" do
    describe "#[]=(index, value)" do
      it "should update element by index" do
        matrix = Mat4.zero
        matrix[0] = 1
        matrix[5] = 1
        matrix[10] = 1
        matrix[15] = 1

        is_identity(matrix)
      end
    end

    describe "#[]=(row, column, value)" do
      it "should update element by coordinates" do
        matrix = Mat4.zero
        matrix[0, 0] = 1
        matrix[1, 1] = 1
        matrix[2, 2] = 1
        matrix[3, 3] = 1

        is_identity(matrix)
      end
    end

    describe "#identity!" do
      matrix = Mat4.new { |i| i.to_f32 }
      matrix.identity!

      0.upto(15) do |i|
        matrix[i].should eq(i % 5 != 0 ? 0 : 1)
      end
    end

    describe "#update!" do
      matrix = Mat4.new { |i| i.to_f32 }
      matrix.update! { |i| (i * i).to_f32 }

      0.upto(15) do |i|
        matrix[i].should eq(i * i)
      end
    end

    describe "#translate!" do
      it "should translate in-place" do
        matrix = Mat4.one
        matrix.translate!(2, 4)

        0.upto(15) do |i|
          row = i % 4
          column = (i / 4).to_i
          matrix[row, column].should eq(column == 3 ? 7 : 1)
        end
      end
    end

    describe "#scale!" do
      it "should scale in-place" do
        matrix = Mat4.one
        matrix.scale!(2, 4)

        0.upto(3) do |i|
          matrix[i].should eq(2)
        end
        4.upto(7) do |i|
          matrix[i].should eq(4)
        end
        8.upto(15) do |i|
          matrix[i].should eq(1)
        end
      end
    end

    describe "#rotate_z!" do
      it "should rotate in-place" do
        matrix = Mat4.one
        matrix.rotate_z!(2)

        0.upto(3) do |i|
          matrix[i].should be_close(0.493f32, 0.001)
        end
        4.upto(7) do |i|
          matrix[i].should be_close(-1.325f32, 0.001)
        end
        8.upto(15) do |i|
          matrix[i].should eq(1)
        end
      end
    end
  end

  context "immutable" do
    describe "#clone" do
      it "should clone" do
        matrix = Mat4.new { |i| i.to_f32 }
        clone = matrix.clone

        0.upto(15) do |v|
          clone[v].should eq(matrix[v])
        end
      end
    end

    describe "#transform(x, y)" do
      it "should transform" do
        matrix = Mat4.one
        transform = matrix.transform(1, 1)
        transform[0].should eq(3)
        transform[1].should eq(3)
      end
    end

    describe "#*(other)" do
      it "performs matrix multiplication" do
        ones = Mat4.one
        matrix = (ones * ones)

        0.upto(15) do |i|
          matrix[i].should eq(4)
        end
      end
    end

    describe "#translate" do
      it "should translate immutably" do
        matrix = Mat4.one
        translated = matrix.translate(2, 4)

        is_ones(matrix)

        0.upto(15) do |i|
          row = i % 4
          column = (i / 4).to_i
          translated[row, column].should eq(column == 3 ? 7 : 1)
        end
      end
    end

    describe "#scale" do
      it "should scale immutably" do
        matrix = Mat4.one
        scaled = matrix.scale(2, 4)

        is_ones(matrix)

        0.upto(3) do |i|
          scaled[i].should eq(2)
        end
        4.upto(7) do |i|
          scaled[i].should eq(4)
        end
        8.upto(15) do |i|
          scaled[i].should eq(1)
        end
      end
    end

    describe "#rotate_z!" do
      it "should rotate in-place" do
        matrix = Mat4.one
        rotated = matrix.rotate_z(2)

        is_ones(matrix)

        0.upto(3) do |i|
          rotated[i].should be_close(0.493f32, 0.001)
        end
        4.upto(7) do |i|
          rotated[i].should be_close(-1.325f32, 0.001)
        end
        8.upto(15) do |i|
          rotated[i].should eq(1)
        end
      end
    end
  end

  context "logging" do
    describe "#inspect" do
      it "should produce a table string" do
        ones = Mat4.one
        ones.inspect.strip.should eq(%{
          +------------+------------+------------+------------+
          |      1.000 |      1.000 |      1.000 |      1.000 |
          +------------+------------+------------+------------+
          |      1.000 |      1.000 |      1.000 |      1.000 |
          +------------+------------+------------+------------+
          |      1.000 |      1.000 |      1.000 |      1.000 |
          +------------+------------+------------+------------+
          |      1.000 |      1.000 |      1.000 |      1.000 |
          +------------+------------+------------+------------+
      }.lines.map(&.strip).join('\n').strip)
      end
    end
  end
end
