import graph;

struct TopologicalSort(Graph)
{
  import std.container;
  alias Node = g.Node;
  Graph g;
  alias g this;
  Node[] nodes;

  this(Graph g)
  {
    this.g = g;
    auto h = new int[](n);

    foreach (u; 0..n)
      foreach (v; g[u])
        ++h[v];

    auto st = SList!Node();
    foreach (i; 0..n)
      if (h[i] == 0) st.insertFront(i);

    while (!st.empty()) {
      auto u = st.front; st.removeFront();
      nodes ~= u;
      foreach (v; g[u]) {
        --h[v];
        if (h[v] == 0) st.insertFront(v);
      }
    }
  }

  pure bool hasCycle() { return nodes.length != n; }
}
TopologicalSort!(Graph) topologicalSort(Graph)(Graph g) { return TopologicalSort!Graph(g); }

/*

  struct TopologicalSort(Graph)

    トポロジカルソートを表します.

    TopologicalSort!Graph(Graph g)

      グラフ g を元にトポロジカルソートを作成します.

    Node[] nodes

      トポロジカルソートの結果を保持する配列です.

    pure bool hasCycle()

      グラフが閉路を含むかどうかを返します.

*/

unittest
{
  import std.algorithm;
  auto g = Graph(8);
  g[0] = [2];
  g[1] = [0, 4];
  g[2] = [3, 6];
  g[4] = [3, 5];
  g[5] = [6, 7];
  g[7] = [6];

  auto ts = g.topologicalSort;
  assert(equal(ts.nodes, [1, 4, 5, 7, 0, 2, 6, 3]));
  assert(!ts.hasCycle);

  auto g2 = Graph(4);
  g2[0] = [1];
  g2[1] = [2];
  g2[2] = [3];
  g2[3] = [1];

  auto ts2 = g2.topologicalSort;
  assert(ts2.hasCycle);
}
