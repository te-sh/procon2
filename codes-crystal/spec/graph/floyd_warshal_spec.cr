require "spec"
require "../../lib/graph/floyd_warshal"

module FloydWarshalSpec
  describe FloydWarshal do
    g = GraphM(Int32).new(5)
    [
      [0, 1, 10], [0, 3, 100], [1, 3, 1000],
      [2, 1, 1], [2, 3, 10000], [3, 0, 5]
    ].each do |(u, v, w)|
      g.add_edge(u, v, w)
    end

    dist = g.floyd_warshal.dist
    it { dist[0][1].should eq 10 }
    it { dist[2][3].should eq 1001 }
    it { dist[3][1].should eq 15 }
    it { dist[4][2].should eq g.inf }
  end
end
