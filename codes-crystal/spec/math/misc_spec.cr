require "spec"
require "../../lib/math/misc"

module MiscSpec
  describe "#isqrt" do
    it { isqrt(2).should eq 1 }
    it { isqrt(4).should eq 2 }
    it { isqrt(224).should eq 14 }
    it { isqrt(2_147_483_647).should eq 46340 }
  end

  describe "#ext_gcd" do
    it { ext_gcd(29, 17).should eq({1, -7, 12}) }
    it { ext_gcd(12, 42).should eq({6, -3, 1}) }
  end
end
