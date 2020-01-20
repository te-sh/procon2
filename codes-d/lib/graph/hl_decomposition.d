module lib.graph.hl_decomposition;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.graph.hl_decomposition
import lib.graph.tree;

struct HlDecomposition(bool setPath = false, Tree)
{
  alias Node = Tree.Node;
  Tree t;
  alias t this;
  Node[] head, path;
  static if (setPath) Node[][] paths;

  this(Tree t)
  {
    this.t = t;
    head = new Node[](n); head[] = n;

    struct US { Node u, s; }
    auto st = SList!US(US(root, root));

    while (!st.empty) {
      auto us = st.front; st.removeFront();

      head[us.u] = us.s;
      auto z = n;
      foreach (v; t[us.u])
        if (head[v] == n && (z == n || size[z] < size[v])) z = v;

      foreach (v; t[us.u])
        if (head[v] == n) st.insertFront(US(v, v == z ? us.s : v));
    }

    static if (setPath) makePath();
  }

private:

  static if (setPath) {
    auto makePath()
    {
      auto pathIndex = 0;
      path = new Node[](n);

      auto q = DList!Node(root);
      while (!q.empty) {
        auto u = q.front; q.removeFront();

        if (u == head[u]) {
          path[u] = pathIndex++;
          paths ~= [u];
        } else {
          path[u] = path[head[u]];
          paths[path[u]] ~= u;
        }

        foreach (v; t[u])
          if (v != parent[u]) q.insertBack(v);
      }
    }
  }

  pure int depthInPath(Node u)
  {
    return depth[u] - depth[head[u]];
  }

  pure Node lca(Node u, Node v)
  {
    while (head[u] != head[v])
      if (depth[head[u]] < depth[head[v]]) v = parent[head[v]];
      else                                 u = parent[head[u]];
    return depth[u] < depth[v] ? u : v;
  }
}
HlDecomposition!(setPath, Tree) hlDecomposition(bool setPath = false, Tree)(Tree t)
{
  return HlDecomposition!(setPath, Tree)(t);
}
// ::::::::::::::::::::

/*

  struct HlDecomposition(bool setPath = false, Tree)

    HL 分解を表します.
    これを用いて LCA を求めることもできます.
    setPath が true のときは path, paths もあわせてセットします.

    HlDecomposition(bool setPath = false, Tree)(Tree t)

      木 t を元に HL 分解を作成します.

    Node[] head;

      ある頂点を含む辺の最も根に近い頂点を保持する配列です.

    pure int depthInPath(Node n)

      頂点 u を含む辺の中での頂点 u の深さを返します.

    pure Node lca(Node u, Node v)

      頂点 u, v の LCA を返します.

    Node[] path;

      ある頂点を含む辺の番号を保持する配列です.
      setPath が false のときは定義されません.

    Node[][] paths;

      ある辺のその辺に含まれる頂点の配列を保持する配列です.
      setPath が false のときは定義されません.

  HlDecomposition!(setPath, Tree) hlDecomposition(bool setPath = false, Tree)(Tree t)

    木 t を元に HL 分解を作成します.

*/

unittest
{
  import lib.graph.graph;
  auto g = Graph(13);

  g.addEdgeB(0, 1);
  g.addEdgeB(0, 2);
  g.addEdgeB(1, 3);
  g.addEdgeB(1, 4);
  g.addEdgeB(1, 5);
  g.addEdgeB(2, 6);
  g.addEdgeB(4, 7);
  g.addEdgeB(4, 8);
  g.addEdgeB(6, 10);
  g.addEdgeB(6, 11);
  g.addEdgeB(11, 12);
  g.addEdgeB(8, 9);

  auto hd = g.tree(0).hlDecomposition;

  assert(hd.head[0] == 0);
  assert(hd.head[1] == 0);
  assert(hd.head[3] == 3);
  assert(hd.head[4] == 0);
  assert(hd.head[6] == 2);

  assert(hd.depthInPath(0) == 0);
  assert(hd.depthInPath(1) == 1);
  assert(hd.depthInPath(3) == 0);
  assert(hd.depthInPath(4) == 2);
  assert(hd.depthInPath(6) == 1);

  assert(hd.lca(1, 3) == 1);
  assert(hd.lca(2, 3) == 0);
  assert(hd.lca(1, 8) == 1);
  assert(hd.lca(7, 9) == 4);

  auto hd2 = g.tree(0).hlDecomposition!true;
  assert(equal(hd2.paths[0], [0, 1, 4, 8, 9]));
  assert(hd2.path[2] == 1);
}
