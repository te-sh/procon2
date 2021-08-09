require "spec"
require "lib/data_structure/aa_tree"

module AATreeSpec
  describe AATree do
    it "#insert, #size, #min and #max" do
      aat = AATree(Int32).new

      aat.size.should eq 0

      aat.insert(2)
      aat.size.should eq 1
      aat.min.should eq 2
      aat.max.should eq 2

      aat.insert(3)
      aat.size.should eq 2
      aat.min.should eq 2
      aat.max.should eq 3

      aat.insert(1)
      aat.size.should eq 3
      aat.min.should eq 1
      aat.max.should eq 3
      
      aat.insert(1)
      aat.size.should eq 4
      aat.min.should eq 1
      aat.max.should eq 3

      aat.insert(6)
      aat.size.should eq 5
      aat.min.should eq 1
      aat.max.should eq 6

      aat.insert(4)
      aat.size.should eq 6
      aat.min.should eq 1
      aat.max.should eq 6
    end

    it "#includes?, #search and #rsearch" do
      aat = AATree(Int32).new
      [2, 3, 1, 1, 4, 6, 4].each do |i|
        aat.insert(i)
      end

      aat.includes?(3).should be_true
      aat.includes?(5).should be_false
      aat.search { |i| i >= 2 }.should eq 2
      aat.search { |i| i > 2 }.should eq 3
      aat.search { |i| i > 6 }.should be_nil
      aat.rsearch { |i| i <= 4 }.should eq 4
      aat.rsearch { |i| i < 4 }.should eq 3
      aat.rsearch { |i| i < 1 }.should be_nil
    end

    it "#remove" do
      aat = AATree(Int32).new
      [2, 3, 1, 1, 4, 6, 4].each do |i|
        aat.insert(i)
      end

      aat.includes?(3).should be_true

      aat.delete(3)
      aat.includes?(3).should be_false
      aat.rsearch { |i| i <= 3 }.should eq 2

      aat.delete(4)
      aat.includes?(4).should be_true
      aat.search { |i| i >= 4 }.should eq 4

      aat.delete(6)
      aat.includes?(6).should be_false
      aat.max.should eq 4
    end
  end
end
