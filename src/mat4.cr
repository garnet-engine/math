struct Garnet::Math::Mat4 < Garnet::Math::SquareMatrix(Float32, 4)
  def *(other : self)
    res = self.class.identity

    mult = ->(res : Mat4, a : Mat4, b : Mat4, row : Int32, col : Int32) do
      a[row, 0] * b[0, col] +
      a[row, 1] * b[1, col] +
      a[row, 2] * b[2, col] +
      a[row, 3] * b[3, col]
    end

    res[0, 0] = mult.call(res, self, other, 0, 0)
    res[0, 1] = mult.call(res, self, other, 0, 1)
    res[0, 2] = mult.call(res, self, other, 0, 2)
    res[0, 3] = mult.call(res, self, other, 0, 3)

    res[1, 0] = mult.call(res, self, other, 1, 0)
    res[1, 1] = mult.call(res, self, other, 1, 1)
    res[1, 2] = mult.call(res, self, other, 1, 2)
    res[1, 3] = mult.call(res, self, other, 1, 3)

    res[2, 0] = mult.call(res, self, other, 2, 0)
    res[2, 1] = mult.call(res, self, other, 2, 1)
    res[2, 2] = mult.call(res, self, other, 2, 2)
    res[2, 3] = mult.call(res, self, other, 2, 3)

    res[3, 0] = mult.call(res, self, other, 3, 0)
    res[3, 1] = mult.call(res, self, other, 3, 1)
    res[3, 2] = mult.call(res, self, other, 3, 2)
    res[3, 3] = mult.call(res, self, other, 3, 3)

    res
  end

  def transform(x : Float32, y : Float32)
    new_x = self[0, 0] * x + self[0, 1] * y + self[0, 3]
    new_y = self[1, 0] * x + self[1, 1] * y + self[1, 3]

    {new_x, new_y}
  end

  def translate(dx : Float32, dy : Float32)
    clone.translate!(dx, dy)
  end
  def translate!(dx : Float32, dy : Float32)
    self[0, 3] = self[0, 0] * dx + self[0, 1] * dy + self[0, 3]
    self[1, 3] = self[1, 0] * dx + self[1, 1] * dy + self[1, 3]
    self[2, 3] = self[2, 0] * dx + self[2, 1] * dy + self[2, 3]
    self[3, 3] = self[3, 0] * dx + self[3, 1] * dy + self[3, 3]

    self
  end

  def scale(x : Float32, y : Float32)
    clone.scale!(x, y)
  end
  def scale!(x : Float32, y : Float32)
    self[0, 0] *= x
    self[1, 0] *= x
    self[2, 0] *= x
    self[3, 0] *= x

    self[0, 1] *= y
    self[1, 1] *= y
    self[2, 1] *= y
    self[3, 1] *= y

    self
  end

  def rotate_z(angle : Float32)
    clone.rotate_z!(angle)
  end
  def rotate_z!(angle : Float32)
    sin = ::Math.sin(angle)
    cos = ::Math.cos(angle)

    tmp_00 = self[0, 0]
    tmp_01 = self[0, 1]
    tmp_02 = self[0, 2]
    tmp_03 = self[0, 3]

    tmp_10 = self[1, 0]
    tmp_11 = self[1, 1]
    tmp_12 = self[1, 2]
    tmp_13 = self[1, 3]

    tmp_20 = self[2, 0]
    tmp_21 = self[2, 1]
    tmp_22 = self[2, 2]
    tmp_23 = self[2, 3]

    tmp_30 = self[3, 0]
    tmp_31 = self[3, 1]
    tmp_32 = self[3, 2]
    tmp_33 = self[3, 3]

    self[0, 0] = tmp_00 * cos + tmp_01 * sin
    self[1, 0] = tmp_10 * cos + tmp_11 * sin
    self[2, 0] = tmp_20 * cos + tmp_21 * sin
    self[3, 0] = tmp_30 * cos + tmp_31 * sin

    self[0, 1] = -tmp_00 * sin + tmp_01 * cos
    self[1, 1] = -tmp_10 * sin + tmp_11 * cos
    self[2, 1] = -tmp_20 * sin + tmp_21 * cos
    self[3, 1] = -tmp_30 * sin + tmp_31 * cos

    self
  end
end
