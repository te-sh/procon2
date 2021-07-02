require "spec"
require "../../lib/math/misc"

module MiscSpec
  describe "#ext_gcd" do
    it { ext_gcd(29, 17).should eq({1, -7, 12}) }
    it { ext_gcd(12, 42).should eq({6, -3, 1}) }
  end
end
