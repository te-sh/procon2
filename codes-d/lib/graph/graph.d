module lib.graph.graph;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.graph.graph
struct Graph
{
  alias Node = int;
  Node n;
  Node[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Node[][](n); }
  void addEdge(Node u, Node v) { g[u] ~= v; }
  void addEdgeB(Node u, Node v) { g[u] ~= v; g[v] ~= u; }
}

struct GraphW(W = int, W i = 10^^9)
{
  alias Node = int, Wt = W, inf = i;
  struct Edge { Node src, dst; Wt wt; alias cap = wt; }
  Node n;
  Edge[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Edge[][](n); }
  void addEdge(Node u, Node v, Wt w) { g[u] ~= Edge(u, v, w); }
  void addEdgeB(Node u, Node v, Wt w) { g[u] ~= Edge(u, v, w); g[v] ~= Edge(v, u, w); }
}

struct GraphM(W = int, W i = 10^^9)
{
  alias Node = int, Wt = W, inf = i;
  Node n;
  Wt[][] g;
  alias g this;
  this(int n) { this.n = n; g = new Wt[][](n, n); }
  static GraphM!(W, i) init(Node n)
  {
    auto g = GraphM!(W, i)(n);
    foreach (i; 0..n) { g[i][] = inf; g[i][i] = 0; }
    return g;
  }
}
// ::::::::::::::::::::

/*

  struct Graph

    グラフを表します. 隣接リスト構造を持ちます.
    辺の重み情報は持ちません.

    Graph(Node n)

      n 頂点の空グラフを返します.

    void addEdge(Node u, Node v)

      頂点 u から頂点 v への有向辺を追加します.

    void addEdge(Node u, Node v)

      頂点 u から頂点 v への有向辺と逆向きの有向辺を追加します.

  struct GraphW(W = int, W i = 10^^9)

    グラフを表します. 隣接リスト構造を持ちます.
    辺の重み情報を型 W で持ちます. i は無限大を代用する数値です.
    重み情報はフロー計算時などでは辺の容量を表します.

    void addEdge(Node u, Node v, Wt w)

      頂点 u から頂点 v への重み w の有向辺を追加します.

    void addEdgeB(Node u, Node v, Wt w)

      頂点 u から頂点 v への重み w 有向辺と逆向きの有向辺を追加します.

  struct GraphM(W = int, W i = 10^^9)

    グラフを表します. 隣接行列構造を持ちます.
    辺の重み情報を型 W で持ちます. i は無限大を代用する数値です.
    ほぼ Floyd-Warshall 専用です.

    static GraphM!(W, i) init(Node n)

      同一頂点間の重みを 0 にし, 異なる頂点間の重みを inf にしたグラフを返します.

*/

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
