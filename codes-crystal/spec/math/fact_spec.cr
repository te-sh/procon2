require "spec"
require "../../lib/math/fact"
require "../../lib/math/mod_int"

module FactSpec
  mod_int(Mint, 7)
  fact = Fact(Mint).new(5)

  describe Fact do
    it { fact.table.should eq [1, 1, 2, 6, 3, 1] }
    it { fact.inv_table.should eq [1, 1, 4, 6, 5, 1] }

    it { fact.perm(5, 2).should eq 6 }
    it { fact.combi(5, 2).should eq 3 }
    it { fact.homo(3, 2).should eq 6 }
  end
end
