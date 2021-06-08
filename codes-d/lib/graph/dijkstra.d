module lib.graph.dijkstra;
import std;

// :::::::::::::::::::: lib.graph.dijkstra
import lib.graph.graph;

/**
 ** Dijkstra 法で指定された頂点から各頂点への最短距離を計算します.
 **/
struct Dijkstra(Graph)
{
  alias Node = Graph.Node, Wt = Graph.Wt, Edge = Graph.Edge;
  /**
   ** 計算に使用したグラフです.
   **/
  Graph g;
  alias g this;
  /**
   ** 頂点ごとの指定された頂点からの最短距離を持つ配列です.
   **/
  Wt[] dist;
  /**
   ** 頂点ごとの指定された頂点からの最短距離のルートにおけるの前の頂点を持つ配列です.
   **/
  Node[] prev;

  /**
   ** グラフ g の頂点 s から各頂点への最短距離を Dijkstra 法で計算した結果を保持する構造体を返します.
   **/
  pure
  {
    @trusted this(Graph g, Node s)
      in { assert(0 <= s && s < g.n); }
    do
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
}
/**
 ** グラフ g の頂点 s から各頂点への最短距離を Dijkstra 法で計算した結果を保持する構造体を返します.
 **/
pure
{
  @trusted auto dijkstra(Graph, Node)(Graph g, Node s)
    in { assert(0 <= s && s < g.n); }
  do
  {
    return Dijkstra!Graph(g, s);
  }
}
// ::::::::::::::::::::

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
