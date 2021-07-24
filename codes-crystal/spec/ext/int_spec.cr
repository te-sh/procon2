require "spec"
require "lib/ext/int"

module IntSpec
  describe Int do
    describe "#cdiv" do
      it { 8.cdiv(3).should eq 3 }
      it { 9.cdiv(3).should eq 3 }
    end

    describe "#bit?" do
      it { 5.bit?(1).should be_false }
      it { 5.bit?(2).should be_true }
    end

    describe "#set_bit" do
      it { 5.set_bit(1).should eq 7 }
      it { 5.set_bit(2).should eq 5 }
    end

    describe "#reset_bit" do
      it { 5.reset_bit(1).should eq 5 }
      it { 5.reset_bit(2).should eq 1 }
    end
  end
end
