module Garnet::Math::Matrix(T)
  include Indexable(T)

  macro fields(*fields)
    @buffer : StaticArray(T, {{fields.size}})

    def self.zero
      self.new { T.zero }
    end

    def self.one
      self.new { T.new(1) }
    end

    def self.identity
      zero.identity!
    end

    def identity!
      update! do |i|
        T.new(i % (column_size + 1) != 0 ? 0 : 1)
      end
      self
    end

    def initialize
      @buffer = StaticArray(T, {{fields.size}}).new(0)
    end

    def initialize(&block : Int32 -> T)
      initialize
      update!(&block)
    end

    def update!(&block : Int32 -> T)
      0.upto(size - 1) do |i|
        self[i] = yield i
      end
    end

    def clone
      self.class.new { |i| @buffer[i] }
    end

    delegate unsafe_fetch, to_unsafe, to: @buffer

    def []=(i, value)
      raise IndexError.new if i < 0 || i >= size
      @buffer[i] = value
    end

    protected def coord_to_index(row : Int, column : Int)
      row + column * column_size
    end

    def [](row : Int, column : Int)
      self[coord_to_index(row, column)]
    end
    def []=(row : Int, column : Int, value : T)
      self[coord_to_index(row, column)] = value
    end

    def row_size
      size
    end
    
    def column_size
      1
    end

    def size
      {{fields.size}}
    end

    {% for name, index in fields %}
      def {{name.id}}
        self[{{index}}]
      end

      def {{name.id}}=(value : T)
        self[{{index}}] = value
      end
    {% end %}

    def ==(other)
      return false if size != other.size
      zip(other).all? { |(a, b)| a == b }
    end

    def +(other : self)
      self.class.new { |i| self[i] + other[i] }
    end
    def -(other : self)
      self.class.new { |i| self[i] - other[i] }
    end
    def *(other : self)
      self.class.new { |i| self[i] * other[i] }
    end
    def /(other : self)
      self.class.new { |i| self[i] / other[i] }
    end

    def +(other : T)
      self.class.new { |i| self[i] + other }
    end
    def -(other : T)
      self.class.new { |i| self[i] - other }
    end
    def *(other : T)
      self.class.new { |i| self[i] * other }
    end
    def /(other : T)
      self.class.new { |i| self[i] / other }
    end

    def -
      self.class.new { |i| -self[i] }
    end

    def dot(other : self)
      map { |i| self[i] * other[i] }.sum
    end
    def **(other : self)
      dot other
    end

    def inspect(io)
      io << String.build do |sb|
        first = true
        names = [
          {% for name, index in fields %}
            :{{name.id}},
          {% end %}
        ]

        sb << self.class.name << '('
        0.upto(size - 1) do |i|
          sb << ", " unless first
          first = false
          sb << names[i] << ": " << self[i].to_f64
        end
        sb << ')'
      end
    end
  end
end
