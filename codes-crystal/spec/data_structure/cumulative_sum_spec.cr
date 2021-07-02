require "spec"
require "../../lib/data_structure/cumulative_sum"

module CumulativeSumSpec
  describe CumulativeSum do
    c = CumulativeSum.new([1, 2, 3, 4, 5])
    it { c[0...1].should eq 1 }
    it { c[0..-2].should eq 10 }
    it { c[...3].should eq 6 }
    it { c[1..2].should eq 5 }
    it { c[-3...-1].should eq 7 }
    it { c[2..].should eq 12 }
  end
end
