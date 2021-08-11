require "spec"
require "lib/math/matrix"

module MatrixSpec
  describe Vector do
    a = Vector(Int32).new(2)
    a[0] = 1
    a[1] = 2
    b = Vector.new([-3, 4])

    it { a.should eq Vector.new([1, 2]) }
    it { (a + b).should eq Vector.new([-2, 6]) }
    it { (a - b).should eq Vector.new([4, -2]) }
    it { (a * 2).should eq Vector.new([2, 4]) }
    it { (a * b).should eq 5 }
  end

  describe Matrix do
    u = Matrix(Int32).unit(2)
    a = Matrix(Int32).new(2, 2)
    a[0][0..1] = [1, -1]
    a[1][0..1] = [-2, 3]
    b = Matrix.new([[1, 2], [3, 4]])

    it { u.should eq Matrix.new([[1, 0], [0, 1]]) }
    it { a.should eq Matrix.new([[1, -1], [-2, 3]]) }
    it { (a + b).should eq Matrix.new([[2, 1], [1, 7]]) }
    it { (a - b).should eq Matrix.new([[0, -3], [-5, -1]]) }
    it { (a * 2).should eq Matrix.new([[2, -2], [-4, 6]]) }
    it { (a * Vector.new([1, 2])).should eq Vector.new([-1, 4]) }
    it { (a * b).should eq Matrix.new([[-2, -2], [7, 8]]) }
    it { (a ** 3).should eq Matrix.new([[11, -15], [-30, 41]]) }
  end
end
