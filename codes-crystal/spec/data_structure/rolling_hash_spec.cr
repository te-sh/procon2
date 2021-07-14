require "spec"
require "lib/data_structure/rolling_hash"

module RollingHashSpec
  describe RollingHash do
    r = RollingHash.new_string("abcabcabd")
    it { (r[0...3] == r[0...3]).should be_true }
    it { (r[0...3] == r[0...4]).should be_false }
    it { (r[0...3] == r[3...6]).should be_true }
    it { (r[0...3] == r[6...9]).should be_false }
  end
end
