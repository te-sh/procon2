import graph;

struct BellmanFord(Graph)
{
  Graph g;
  alias g this;
  alias Node = g.Node, Wt = g.Wt;
  Wt[] dist;
  Node[] prev;

  this(Graph g, Node s)
  {
    this.g = g;
    auto sent = n;

    dist = new Wt[](n);
    dist[] = inf*2;
    dist[s] = 0;

    prev = new Node[](n);
    prev[] = sent;

    foreach (k; 0..n)
      foreach (i; 0..n)
        foreach (e; g[i])
          if (dist[e.dst] > dist[e.src] + e.wt) {
            dist[e.dst] = dist[e.src] + e.wt;
            prev[e.dst] = e.src;
            if (k == n-1) dist[e.dst] = -inf;
          }
  }
}
BellmanFord!Graph bellmanFord(Graph, Node)(Graph g, Node s) { return BellmanFord!Graph(g, s); }

/*

  struct BellmanFord(Graph)

    Bellman-Ford 法により最短距離を計算します. Graph は重みつきグラフです.

    BellmanFord!Graph(Graph g, Node s)

      頂点 s から各頂点への最短距離を dist に, 前の頂点を prev にセットします.

    Wt[] dist;

      ある頂点の頂点 s からの最短距離を保持する配列です.

    Node[] prev;

      ある頂点の頂点 s からの最短距離になる経路の前の頂点を保持する配列です.

  BellmanFord!Graph bellmanFord(Graph, Node)(Graph g, Node s)

    頂点 s から各頂点への最短距離を dist に, 前の頂点を prev にセットします.

*/

unittest
{
  auto g = GraphW!int(9);
  g.addEdge(0, 1, 5); g.addEdge(0, 2, 4);
  g.addEdge(1, 2, -2); g.addEdge(1, 3, 1);
  g.addEdge(2, 4, 1); g.addEdge(2, 5, 4);
  g.addEdge(3, 5, 3); g.addEdge(3, 6, -1);
  g.addEdge(4, 5, 4);
  g.addEdge(6, 7, -1);
  g.addEdge(7, 8, -1);
  g.addEdge(8, 6, -1);

  auto dist = g.bellmanFord(0).dist;
  assert(dist[1] == 5);
  assert(dist[2] == 3);
  assert(dist[5] == 7);
  assert(dist[6] <= -g.inf);
}
