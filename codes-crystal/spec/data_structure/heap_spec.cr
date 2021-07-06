require "spec"
require "lib/data_structure/heap"

module HeapSpec
  describe Heap do
    describe "#initialize" do
      h = Heap(Int32).new
      it { h.empty?.should be_true }
    end

    describe "#initialize with cmp" do
      h = Heap(Int32).new { |a, b| b <=> a }
      it { h.empty?.should be_true }
    end

    describe "#initialize with init" do
      h = Heap(Int32).new([2, 3, 1])
      it { h.empty?.should be_false }
      it { h.first.should eq 1 }
    end

    describe "#initialize with init and cmp" do
      h = Heap(Int32).new([2, 3, 1]) { |a, b| b <=> a }
      it { h.empty?.should be_false }
      it { h.first.should eq 3 }
    end

    describe "#push" do
      h = Heap(Int32).new
      it {
        h.push(2)
        h.empty?.should be_false
        h.size.should eq 1
        h.first.should eq 2

        h.push(3)
        h.empty?.should be_false
        h.size.should eq 2
        h.first.should eq 2

        h.push(1)
        h.empty?.should be_false
        h.size.should eq 3
        h.first.should eq 1
      }
    end

    describe "#pop" do
      h = Heap(Int32).new([2, 3, 1])
      it {
        h.pop.should eq 1
        h.empty?.should be_false
        h.size.should eq 2
        h.first.should eq 2

        h.pop.should eq 2
        h.empty?.should be_false
        h.size.should eq 1
        h.first.should eq 3

        h.pop.should eq 3
        h.empty?.should be_true
      }
    end
  end
end
