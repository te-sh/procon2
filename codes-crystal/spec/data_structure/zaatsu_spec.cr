require "spec"
require "lib/data_structure/zaatsu"

module ZaatsuSpec
  describe Zaatsu do
    za = Zaatsu.new([1, 8, 2, 6], [4, 1])
    it { za.size.should eq 5 }
    it { za.comp(1).should eq 0 }
    it { za.comp(6).should eq 3 }
    it { za.uncomp(2).should eq 4 }
    it { za.uncomp(4).should eq 8 }
  end
end
