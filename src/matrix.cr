abstract struct Garnet::Math::Matrix(T, C)
  include Indexable(T)

  @buffer : StaticArray(T, C)

  macro matrix_property(name, index)
    def {{name.id}}
      self[{{index}}]
    end

    def {{name.id}}=(value : T)
      self[{{index}}] = value
    end
  end

  macro matrix_properties(names)
    {% for name, index in names %}
      def {{name.id}}
        self[{{index}}]
      end

      def {{name.id}}=(value : T)
        self[{{index}}] = value
      end
    {% end %}
  end

  def self.zero
    self.new { T.zero }
  end

  def self.one
    self.new { T.new(1) }
  end

  def initialize
    @buffer = StaticArray(T, C).new(0)
  end

  def initialize(&block : Int32 -> T)
    initialize
    update!(&block)
  end

  def update!(&block : Int32 -> T)
    0.upto(size - 1) do |i|
      self[i] = yield i
    end
    self
  end

  def clone
    self.class.new { |i| @buffer[i] }
  end

  def to_unsafe
    @buffer
  end

  def size
    row_size * column_size
  end

  def row_size
    C
  end

  def column_size
    C / row_size
  end

  def unsafe_fetch(i)
    raise IndexError.new if i < 0 || i >= size
    @buffer[i]
  end

  def [](row, col)
    raise IndexError.new if row < 0 || row >= row_size
    raise IndexError.new if col < 0 || col >= column_size
    self[row + col * column_size]
  end

  def []=(i, value : T)
    raise IndexError.new if i < 0 || i >= size
    @buffer[i] = value
  end

  def []=(row, col, value : T)
    raise IndexError.new if row < 0 || row >= row_size
    raise IndexError.new if col < 0 || col >= column_size
    self[row + col * column_size] = value
  end

  def ==(other)
    return false if row_size != other.row_size
    return false if column_size != other.column_size
    zip(other).all? { |(a, b)| a == b }
  end

  def -
    clone.update! { |i| -@buffer[i] }
  end

  def inspect(io)
    io << String.build do |sb|
      # Print first line
      0.upto(column_size - 1) { |c| sb << "+------------" }
      sb << "+\n"

      0.upto(row_size - 1) do |r|
        0.upto(column_size - 1) do |c|
          sb << sprintf("| %10.3f ", self[r, c].to_f64)
        end
        sb << "|\n"

        0.upto(column_size - 1) { |c| sb << "+------------" }
        sb << "+\n"
      end
    end
  end
end

abstract struct Garnet::Math::SquareMatrix(T, C) < Garnet::Math::Matrix(T, C)
  def column_size
    row_size
  end

  def self.identity
    zero.identity!
  end

  def identity! 
    update! do |i|
      T.new(i % (column_size + 1) != 0 ? 0 : 1)
    end
  end
end
