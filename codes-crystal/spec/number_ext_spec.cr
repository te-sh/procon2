require "spec"
require "lib/number_ext"

module NumberExtSpec
  describe Int do
    describe "#cdiv" do
      it { 8.cdiv(3).should eq 3 }
      it { 9.cdiv(3).should eq 3 }
    end
  end

  describe Int32 do
    describe "#isqrt" do
      it { 2.isqrt.should eq 1 }
      it { 4.isqrt.should eq 2 }
      it { 224.isqrt.should eq 14 }
      it { 2_147_483_647.isqrt.should eq 46_340 }
    end
  end

  describe Int64 do
    describe "#isqrt" do
      it { 2_147_483_647_i64.isqrt.should eq 46_340 }
      it { 9_223_372_036_854_775_807.isqrt.should eq 3_037_000_499 }
    end
  end
end
