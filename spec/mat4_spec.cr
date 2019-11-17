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
  context "mutations" do
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
end
