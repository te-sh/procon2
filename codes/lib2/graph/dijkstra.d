import graph;

struct Dijkstra(Graph)
{
  import std.array, std.container;
  Graph g;
  alias Node = g.Node, Wt = g.Wt, Edge = Graph.Edge;

  this(ref Graph g) { this.g = g; }

  void run(Node s, out Wt[] dist, out Node[] prev)
  {
    auto n = g.n, sent = n;

    dist = new Wt[](n);
    dist[] = g.inf;
    dist[s] = 0;

    prev = new Node[](n);
    prev[] = sent;

    auto q = heapify!("a.wt > b.wt")(Array!Edge(Edge(sent, s, 0)));
    while (!q.empty) {
      auto e = q.front; q.removeFront();
      if (prev[e.dst] != sent) continue;
      prev[e.dst] = e.src;
      foreach (f; g[e.dst]) {
        auto w = e.wt+f.wt;
        if (dist[f.dst] > w) {
          dist[f.dst] = w;
          q.insert(Edge(f.src, f.dst, w));
        }
      }
    }
  }

  auto run(Node s)
  {
    Wt[] dist;
    Node[] prev;
    run(s, dist, prev);
    return dist;
  }
}
auto dijkstra(G, N)(G g, N s) { return Dijkstra!G(g).run(s); }

/*

  Dijkstra(Graph)

    幅優先探索を行う構造体です. Graph は重みつきグラフです.

  dijkstra.run(s, dist, prev)

    頂点 s から各頂点への最短距離を dist に, 前の頂点を prev に入れます.

  dijkstra.run(s)

    頂点 s から各頂点への最短距離を返します.

  dijkstra(g, n)

    頂点 s から各頂点への最短距離を返します.

*/

unittest
{
  auto g = GraphW!int(6);
  g.addEdge(0, 1, 5); g.addEdge(0, 2, 4); g.addEdge(0, 3, 2);
  g.addEdge(1, 0, 5); g.addEdge(1, 2, 2); g.addEdge(1, 4, 6);
  g.addEdge(2, 0, 4); g.addEdge(2, 1, 2); g.addEdge(2, 3, 3); g.addEdge(2, 5, 2);
  g.addEdge(3, 0, 2); g.addEdge(3, 5, 6);
  g.addEdge(4, 1, 6); g.addEdge(4, 5, 4);
  g.addEdge(5, 2, 2); g.addEdge(5, 3, 6); g.addEdge(5, 4, 4);

  auto dist = g.dijkstra(0);

  assert(dist[4] == 10);
  assert(dist[5] == 6);
}
