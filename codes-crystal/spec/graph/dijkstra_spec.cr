require "spec"
require "lib/graph/dijkstra"

module DijkstraSpec
  describe Dijkstra do
    g = GraphW(Int32).new(6)
    [
      {0, 1, 5}, {0, 2, 4}, {0, 3, 2},
      {1, 0, 5}, {1, 2, 2}, {1, 4, 6},
      {2, 0, 4}, {2, 1, 2}, {2, 3, 3}, {2, 5, 2},
      {3, 0, 2}, {3, 5, 6},
      {4, 1, 6}, {4, 5, 4},
      {5, 2, 2}, {5, 3, 6}, {5, 4, 4}
    ].each do |u, v, w|
      g.add_edge(u, v, w)
    end

    dist = g.dijkstra(0).dist

    it { dist[4].should eq 10 }
    it { dist[5].should eq 6 }
  end
end
