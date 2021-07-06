require "spec"
require "lib/math/mod_int"

module ModIntSpec
  struct Mint < ModInt; @@mod = 7; end
  m1 = Mint.new(3)
  m2 = Mint.new(8)

  describe "#initialize" do
    it { m1.should eq 3 }
    it { m2.should eq 1 }
  end

  describe "#-" do
    it { (-m1).should eq 4 }
  end

  describe "#+" do
    it { (m1 + Mint.new(2)).should eq 5 }
    it { (m1 + Mint.new(5)).should eq 1 }
    it { (m1 + 2).should eq 5 }
    it { (m1 + 5).should eq 1 }
  end

  describe "#-" do
    it { (m1 - Mint.new(2)).should eq 1 }
    it { (m1 - Mint.new(5)).should eq 5 }
    it { (m1 - 2).should eq 1 }
    it { (m1 - 5).should eq 5 }
  end

  describe "#*" do
    it { (m1 * Mint.new(2)).should eq 6 }
    it { (m1 * Mint.new(5)).should eq 1 }
    it { (m1 * 2).should eq 6 }
    it { (m1 * 5).should eq 1 }
  end

  describe "#//" do
    it { (m1 // Mint.new(2)).should eq 5 }
    it { (m1 // 2).should eq 5 }
  end

  describe "#**" do
    it { (m1 ** 4).should eq 4 }
  end

  describe "#inv" do
    it { m1.inv.should eq 5 }
    it { m2.inv.should eq 1 }
  end
end
