require "spec"
require "lib/math/misc"

module MiscSpec
  describe "#powr" do
    it { powr(2, 0).should eq 1 }
    it { powr(2, 1).should eq 2 }
    it { powr(2, 5).should eq 32 }
    it { powr(2, 0) { |a, b| (a*b)%7 }.should eq 1 }
    it { powr(2, 1) { |a, b| (a*b)%7 }.should eq 2 }
    it { powr(2, 5) { |a, b| (a*b)%7 }.should eq 4 }
  end

  describe "#ext_gcd" do
    it { ext_gcd(29, 17).should eq({1, -7, 12}) }
    it { ext_gcd(12, 42).should eq({6, -3, 1}) }
  end

  describe "#bit_subsets" do
    it "includes_zero is false" do
      a = [] of Int32
      bit_subsets(0b1011) { |i| a << i }
      a.should eq [0b1011, 0b1010, 0b1001, 0b1000, 0b0011, 0b0010, 0b0001]
    end

    it "includes_zero is true" do
      a = [] of Int32
      bit_subsets(0b1011, includes_zero: true) { |i| a << i }
      a.should eq [0b1011, 0b1010, 0b1001, 0b1000, 0b0011, 0b0010, 0b0001, 0b0000]
    end
  end

  describe "#bit_zeta_trans_subset" do
    f = [0, 1, 2, 3, 4, 5, 6, 7]
    it { bit_zeta_trans_subset(3, f) { |a, b| a + b }.should eq [0, 1, 2, 6, 4, 10, 12, 28] }
  end

  describe "#bit_zeta_trans_superset" do
    f = [0, 1, 2, 3, 4, 5, 6, 7]
    it { bit_zeta_trans_superset(3, f) { |a, b| a + b }.should eq [28, 16, 18, 10, 22, 12, 13, 7] }
  end
end
