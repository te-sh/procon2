require "spec"
require "../../lib/math/misc"

module MiscSpec
  describe "#isqrt" do
    it { isqrt(2).should eq 1 }
    it { isqrt(4).should eq 2 }
    it { isqrt(224).should eq 14 }
    it { isqrt(2_147_483_647).should eq 46_340 }
    it { isqrt(2_147_483_647_i64).should eq 46_340 }
    it { isqrt(9_223_372_036_854_775_807).should eq 3_037_000_499 }
  end

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
end
