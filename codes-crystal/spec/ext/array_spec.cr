require "spec"
require "lib/ext/array"

module ArraySpec
  describe Array do
    it { Array.new_md(2, 3, 0).should eq [[0, 0, 0], [0, 0, 0]] }
  end
end
