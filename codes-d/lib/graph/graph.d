module lib.graph.graph;
import std;

// :::::::::::::::::::: lib.graph.graph
/**
 ** グラフを表します. 隣接リスト構造を持ちます.
 ** 辺の重み情報は持ちません.
 **/
struct Graph
{
  alias Node = int;
  /**
   ** 頂点数です.
   **/
  Node n;
  /**
   ** 辺の隣接リストです.
   **/
  Node[][] g;
  alias g this;

  pure nothrow @safe
  {
    /**
     ** 頂点数が n のグラフを返します.
     **/
    this(Node n)
    {
      this.n = n;
      g = new Node[][](n);
    }
    /**
     ** グラフに頂点 u から頂点 v への有向辺を追加します.
     **/
    void addEdge(Node u, Node v)
      in { assert(0 <= u && u < n && 0 <= v && v < n); }
    do
    {
      g[u] ~= v;
    }
    /**
     ** グラフに頂点 u から頂点 v への有向辺および頂点 v から頂点 u への有向辺を作成します.
     **/
    void addEdgeB(Node u, Node v)
      in { assert(0 <= u && u < n && 0 <= v && v < n); }
    do
    {
      g[u] ~= v;
      g[v] ~= u;
    }
  }
}

/**
 ** グラフを表します. 隣接リスト構造を持ちます.
 ** 辺の重み情報を持ちます.
 ** i は無限大の代用値です.
 **/
struct GraphW(W = int, W i = 10^^9)
{
  alias Node = int, Wt = W, inf = i;
  /**
   ** 辺を表します.
   **/
  struct Edge
  {
    /**
     ** 辺の始点および終点です.
     **/
    Node src, dst;
    /**
     ** 辺の重みです.
     ** 最大フローの計算の場合には容量を表します.
     **/
    Wt wt;
    alias cap = wt;
  }
  /**
   ** 頂点数です.
   **/
  Node n;
  /**
   ** 辺の隣接リストです.
   **/
  Edge[][] g;
  alias g this;

  pure nothrow @safe
  {
    /**
     ** 頂点数が n のグラフを返します.
     **/
    this(Node n)
    {
      this.n = n;
      g = new Edge[][](n);
    }
    /**
     ** グラフに頂点 u から頂点 v への有向辺を追加します.
     **/
    void addEdge(Node u, Node v, Wt w)
      in { assert(0 <= u && u < n && 0 <= v && v < n); }
    do
    {
      g[u] ~= Edge(u, v, w);
    }
    /**
     ** グラフに頂点 u から頂点 v への有向辺および頂点 v から頂点 u への有向辺を作成します.
     **/
    void addEdgeB(Node u, Node v, Wt w)
      in { assert(0 <= u && u < n && 0 <= v && v < n); }
    do
    {
      g[u] ~= Edge(u, v, w);
      g[v] ~= Edge(v, u, w);
    }
  }
}

/**
 ** グラフを表します. 隣接行列構造を持ちます.
 ** i は無限大の代用値です.
 **/
struct GraphM(W = int, W i = 10^^9)
{
  alias Node = int, Wt = W, inf = i;
  /**
   ** 頂点数です.
   **/
  Node n;
  /**
   ** 辺の隣接行列です.
   **/
  Wt[][] g;
  alias g this;

  pure nothrow @safe
  {
    /**
     ** 頂点数が n のグラフを返します.
     **/
    this(int n)
    {
      this.n = n;
      g = new Wt[][](n, n);
    }
    /**
     ** 頂点数が n, 同じ頂点間の距離が 0, 異なる頂点間の距離が i であるグラフを返します.
     **/
    static GraphM!(W, i) init(Node n)
    {
      auto g = GraphM!(W, i)(n);
      foreach (i; 0..n) { g[i][] = inf; g[i][i] = 0; }
      return g;
    }
  }
}
// ::::::::::::::::::::

unittest
{
  auto g = Graph(3);
  g.addEdge(0, 1);
  g.addEdgeB(1, 2);

  assert(equal(g[0], [1]));
  assert(equal(g[1], [2]));
  assert(equal(g[2], [1]));
}

unittest
{
  auto g = GraphW!int(3);
  g.addEdge(0, 1, 3);
  g.addEdgeB(1, 2, 4);

  assert(equal(g[0], [g.Edge(0, 1, 3)]));
  assert(equal(g[1], [g.Edge(1, 2, 4)]));
  assert(equal(g[2], [g.Edge(2, 1, 4)]));
}

unittest
{
  auto g = GraphM!double.init(3);
  assert(g[0][0] == 0);
  assert(g[0][1] == g.inf);
}
