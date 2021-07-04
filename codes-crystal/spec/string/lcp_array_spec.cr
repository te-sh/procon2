require "spec"
require "../../lib/string/suffix_array"
require "../../lib/string/lcp_array"

module LcpArraySpec
  describe LcpArray do
    s = SuffixArray.new("abracadabra")
    l = LcpArray.new(s)

    it { l[0].should eq 0 }
    it { l[1].should eq 1 }
    it { l[2].should eq 4 }
    it { l[3].should eq 1 }
    it { l[4].should eq 1 }
    it { l[5].should eq 0 }
    it { l[6].should eq 3 }
    it { l[7].should eq 0 }
    it { l[8].should eq 0 }
    it { l[9].should eq 0 }
    it { l[10].should eq 2 }
  end
end
