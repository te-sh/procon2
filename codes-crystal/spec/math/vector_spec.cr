require "spec"
require "lib/math/vector"

module VectorSpec
  describe Vector do
    a = Vector.new([1, 2, 3])
    b = Vector.new([4, 5, 6])

    describe "#+" do
      it { (a + b).to_a.should eq [5, 7, 9] }
    end

    describe "#-" do
      it { (a - b).to_a.should eq [-3, -3, -3] }
    end
  end
end
