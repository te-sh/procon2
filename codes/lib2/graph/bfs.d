import graph;

struct BFS(Graph)
{
  import std.algorithm, std.container;
  Graph g;
  alias Node = g.Node;
  void delegate(Node)[] findNode;

  this(ref Graph g) { this.g = g; }

  auto run(Node s)
  {
    auto visited = new bool[](g.n);
    auto q = DList!(Node)(s);
    visited[s] = true;
    findNode.each!(f => f(s));

    while (!q.empty) {
      auto u = q.front; q.removeFront();
      foreach (v; g[u])
        if (!visited[v]) {
          visited[v] = true;
          findNode.each!(f => f(v));
          q.insertBack(v);
        }
    }
  }
}
auto bfs(G)(ref G g) { return BFS!G(g); }

struct BFSW(Graph)
{
  import std.algorithm, std.container;
  Graph g;
  alias Node = g.Node, Edge = g.Edge;
  void delegate(Node)[] findNode;
  void delegate(Edge)[] findEdge;

  this(ref Graph g) { this.g = g; }
  auto run(Node s)
  {
    auto visited = new bool[](g.n);
    auto q = DList!(Node)(s);
    visited[s] = true;
    findNode.each!(f => f(s));

    while (!q.empty) {
      auto u = q.front; q.removeFront();
      foreach (e; g[u])
        if (!visited[e.dst]) {
          visited[e.dst] = true;
          findNode.each!(f => f(e.dst));
          findEdge.each!(f => f(e));
          q.insertBack(e.dst);
        }
    }
  }
}
auto bfsw(G)(ref G g) { return BFSW!G(g); }

/*

  BFS(Graph)

    幅優先探索を行う構造体です. Graph は重みなしグラフです.

  bfs(g)

    BFS 構造体を生成します.

  bfs.findNode ~= (Node u) { ... }

    頂点が見つかるごとに呼ばれます.

  bfs.run(s)

    頂点 s を起点に探索を実行します.

  BFSW(Graph)

    幅優先探索を行う構造体です. Graph は重みつきグラフです.

  bfsw(g)

    BFS 構造体を生成します.

  bfs.findNode ~= (Node v) { ... }

    頂点が見つかるごとに呼ばれます.

  bfs.findEdge ~= (Edge e) { ... }

    辺が見つかるごとに呼ばれます.

  bfs.run(s)

    頂点 s を起点に探索を実行します.

 */

unittest
{
  auto g = Graph(4); alias Node = g.Node;
  g.addEdge(0, 1);
  g.addEdge(1, 2);
  g.addEdge(0, 3);

  auto bfs = bfs(g);
  Node[] v;

  bfs.findNode ~= (Node u) { v ~= u; };
  bfs.run(0);
  assert(v == [0, 1, 3, 2]);
}

unittest
{
  auto g = GraphW!int(4); alias Node = g.Node, Edge = g.Edge;
  g.addEdge(0, 1, 1);
  g.addEdge(1, 2, 2);
  g.addEdge(0, 3, 3);

  auto bfs = bfsw(g);
  Node[] v;
  Edge[] e;

  bfs.findNode ~= (Node f) { v ~= f; };
  bfs.findEdge ~= (Edge f) { e ~= f; };
  bfs.run(0);
  assert(v == [0, 1, 3, 2]);
  assert(e == [Edge(0, 1, 1), Edge(0, 3, 3), Edge(1, 2, 2)]);
}
