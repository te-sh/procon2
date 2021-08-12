require "spec"
require "lib/graph/ford_fulkerson"

module FordFulkersonSpec
  alias Edge = GraphW::Edge

  describe FordFulkerson do
    g = GraphW(Int32).new(7)
    [
      {0, 1, 5}, {0, 2, 2}, {0, 3, 8},
      {1, 2, 3}, {1, 4, 4},
      {2, 3, 4}, {2, 4, 4},
      {3, 4, 6}
    ].each do |u, v, w|
      g.add_edge(u, v, w)
    end

    f = g.ford_fulkerson(0, 4)

    it { f.flow.should eq 13 }

    it "#flow_graph" do
      fg = f.flow_graph
      fg[0][0].should eq Edge.new(0, 1, 5)
      fg[0][1].should eq Edge.new(0, 2, 2)
      fg[0][2].should eq Edge.new(0, 3, 6)
      fg[1][0].should eq Edge.new(1, 2, 1)
      fg[1][1].should eq Edge.new(1, 4, 4)
      fg[2][0].should eq Edge.new(2, 4, 3)
      fg[3][0].should eq Edge.new(3, 4, 6)
    end
  end
end
