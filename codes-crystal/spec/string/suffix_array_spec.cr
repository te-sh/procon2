require "spec"
require "lib/string/suffix_array"

module SuffixArraySpec
  describe SuffixArray do
    s = SuffixArray.new("aeadacab")

    it { s[0].should eq 6 }
    it { s[1].should eq 4 }
    it { s[2].should eq 2 }
    it { s[3].should eq 0 }
    it { s[4].should eq 7 }
    it { s[5].should eq 5 }
    it { s[6].should eq 3 }
    it { s[7].should eq 1 }
  end
end
