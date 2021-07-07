require "spec"
require "lib/io/procon_io"

module ProconIOSpec
  ins, outs = IO::Memory.pipe
  io = ProconIO.new(ins, outs)
  n, m = 2, 3

  describe ProconIO do
    describe "#get" do
      it { outs.puts "1"; io.get.should eq 1 }
      it { outs.puts "2"; io.get(String).should eq "2" }
      it { outs.puts "2 3"; io.get(Int32, String).should eq({2, "3"}) }
      it { outs.puts "3 4"; io.get2.should eq({3, 4}) }
      it { outs.puts "4 5"; io.get2(String).should eq({"4", "5"}) }
    end

    describe "#get_a" do
      it { outs.puts "5 6"; io.get_a(n).should eq [5, 6] }
      it { outs.puts "6 7"; io.get_a(n, String).should eq ["6", "7"] }
    end

    describe "#get_c" do
      it { outs.puts "1\n2"; io.get_c(n).should eq [1, 2] }
      it { outs.puts "3\n4"; io.get_c(n, String).should eq ["3", "4"] }
      it { outs.puts "5 6\n7 8"; io.get_c(n, Int32, String).should eq({[5, 7], ["6", "8"]}) }
      it { outs.puts "8 9\n0 1"; io.get2_c(n).should eq({[8, 0], [9, 1]}) }
      it { outs.puts "1 2\n3 4"; io.get2_c(n, String).should eq({["1", "3"], ["2", "4"]}) }
    end

    describe "#get_m" do
      it { outs.puts "1 2 3\n4 5 6"; io.get_m(n, m).should eq [[1, 2, 3], [4, 5, 6]] }
      it { outs.puts "7 8 9\n0 1 2"; io.get_m(n, m, String).should eq [["7", "8", "9"], ["0", "1", "2"]] }
    end
  end
end
