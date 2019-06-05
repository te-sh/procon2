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
  ref auto init() { foreach (i; 0..n) { g[i][] = inf; g[i][i] = 0; } return this; }
}

/*

  Graph

    グラフを表す構造体です. 辺の重み情報は持ちません.
    隣接リスト構造を持ちます.

  g.addEdge(u, v)

    頂点 u から頂点 v への有向辺を追加します.

  g.addEdgeB(u, v)

    頂点 u から頂点 v への有向辺と逆向きの有向辺を追加します.

  GraphW!(W, inf)

    グラフを表す構造体です.
    辺の重み情報を型 W で持ちます. inf は無限大を代用する数値です.
    重み情報はフロー計算時などでは辺の容量を表します.
    隣接リスト構造を持ちます.

  g.addEdge(u, v, w)

    頂点 u から頂点 v への重み w の有向辺を追加します.

  g.addEdgeB(u, v, w)

    頂点 u から頂点 v への重み w 有向辺と逆向きの有向辺を追加します.

  GraphM!(W, inf)

    グラフを表す構造体です.
    辺の重み情報を型 W で持ちます. inf は無限大を代用する数値です.
    隣接行列構造を持ちます.
    ほぼ Floyd-Warshall 専用です.

  g.init

    同一頂点間の重みを 0 にし, 異なる頂点間の重みを inf にします.

 */
