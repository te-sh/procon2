module lib.graph.dijkstra;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import lib.graph.graph;

struct Dijkstra(Graph)
{
  Graph g;
  alias g this;
  alias Node = g.Node, Wt = g.Wt, Edge = g.Edge;
  Wt[] dist;
  Node[] prev;

  this(Graph g, Node s)
  {
    this.g = g;
    auto sent = n;

    dist = new Wt[](n);
    dist[] = g.inf;
    dist[s] = 0;

    prev = new Node[](n);
    prev[] = sent;

    auto q = heapify!("a.wt>b.wt")(Array!Edge(Edge(sent, s, 0)));
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
}
Dijkstra!Graph dijkstra(Graph, Node)(Graph g, Node s) { return Dijkstra!Graph(g, s); }

/*

  struct Dijkstra(Graph)

    Dijkstra 法により最短距離を計算します. Graph は重みつきグラフです.

    Dijkstra!Graph(Graph g, Node s)

      頂点 s から各頂点への最短距離を dist に, 前の頂点を prev にセットします.

    Wt[] dist;

      ある頂点の頂点 s からの最短距離を保持する配列です.

    Node[] prev;

      ある頂点の頂点 s からの最短距離になる経路の前の頂点を保持する配列です.

  Dijkstra!Graph dijkstra(Graph, Node)(Graph g, Node s)

    頂点 s から各頂点への最短距離を dist に, 前の頂点を prev にセットします.

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

  auto dist = g.dijkstra(0).dist;
  assert(dist[4] == 10);
  assert(dist[5] == 6);
}
