module lib.graph.bellman_ford;
import std;

// :::::::::::::::::::: lib.graph.bellman_ford
import lib.graph.graph;

/**
 ** Bellman-Ford 法で指定された頂点から各頂点への最短距離を計算します.
 **/
struct BellmanFord(Graph)
{
  alias Node = Graph.Node, Wt = Graph.Wt;
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

  pure nothrow @safe
  {
    /**
     ** グラフ g の頂点 s から各頂点への最短距離を Bellman-Ford 法で
     ** 計算した結果を保持する構造体を返します.
     **/
    this(Graph g, Node s)
      in { assert(0 <= s && s < g.n); }
    do
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
            if (dist[i] < inf && dist[e.dst] > dist[e.src] + e.wt) {
              dist[e.dst] = dist[e.src] + e.wt;
              prev[e.dst] = e.src;
              if (k == n-1) dist[e.dst] = -inf;
            }

      auto st = SList!int();
      foreach (i; 0..n)
        if (dist[i] <= -inf)
          st.insertFront(i);

      while (!st.empty) {
        auto u = st.front; st.removeFront();
        foreach (e; g[u])
          if (dist[e.dst] > -inf) {
            dist[e.dst] = -inf;
            st.insertFront(e.dst);
          }
      }
    }
  }
}

pure nothrow @safe
{
  /**
   ** グラフ g の頂点 s から各頂点への最短距離を Bellman-Ford 法で
   ** 計算した結果を保持する構造体を返します.
   **/
  auto bellmanFord(Graph, Node)(Graph g, Node s)
    in { assert(0 <= s && s < g.n); }
  do
  {
    return BellmanFord!Graph(g, s);
  }
}
// ::::::::::::::::::::

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
