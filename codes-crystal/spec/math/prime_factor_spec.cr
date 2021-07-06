require "spec"
require "lib/math/prime_factor"

module PrimeFactorSpec
  describe PrimeFactor do
    describe "#primes" do
      it { PrimeFactor.new(2).primes.should eq [2] }
      it { PrimeFactor.new(5).primes.should eq [2, 3, 5] }
      it { PrimeFactor.new(30).primes.should eq [2, 3, 5, 7, 11, 13, 17, 19, 23, 29] }
    end

    describe "#factors" do
      pf = PrimeFactor.new(5)
      it { pf.div(23).should eq [PrimeFactor::Factor.new(23, 1)] }
      it { pf.div(24).should eq [PrimeFactor::Factor.new(2, 3), PrimeFactor::Factor.new(3, 1)] }
      it { pf.div(25).should eq [PrimeFactor::Factor.new(5, 2)] }
      it { pf.div(31).should eq [PrimeFactor::Factor.new(31, 1)] }
    end

    describe "#divisors" do
      pf = PrimeFactor.new(100)
      it { pf.divisors(60).should eq [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60] }
    end
  end
end
