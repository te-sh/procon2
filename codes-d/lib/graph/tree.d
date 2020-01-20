module lib.graph.tree;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import lib.graph.graph;

struct Tree(Graph)
{
  alias Node = Graph.Node;
  Graph g;
  alias g this;
  Node root;
  Node[] parent;
  int[] size, depth;

  this(Graph g, Node r)
  {
    this.g = g;
    this.root = r;

    parent = new Node[](n);
    depth = new int[](n);
    depth[] = -1;

    struct UP { Node u, p; }
    auto st1 = SList!UP(UP(r, r));
    auto st2 = SList!UP();
    while (!st1.empty) {
      auto up = st1.front; st1.removeFront();

      parent[up.u] = up.p;
      depth[up.u] = depth[up.p] + 1;

      foreach (v; g[up.u])
        if (v != up.p) {
          st1.insertFront(UP(v, up.u));
          st2.insertFront(UP(v, up.u));
        }
    }

    size = new int[](n);
    size[] = 1;

    while (!st2.empty) {
      auto up = st2.front; st2.removeFront();
      size[up.p] += size[up.u];
    }
  }

  pure auto children(Node u) { return g[u].filter!(v => v != parent[u]); }
}
Tree!Graph tree(Graph, Node)(Graph g, Node r) { return Tree!Graph(g, r); }

/*

  struct Tree(Graph)

    木を表します.

    Tree!(Graph)(ref Graph g, Node r) { this.g = g; }

      グラフ g を元に頂点 r を根とする木を作成します.

    Node[] parent;

      ある頂点の親頂点を保持する配列です.

    int[] depth;

      ある頂点の根からの深さを保持する配列です.

    int[] size;

      ある頂点のその頂点を根とする部分木の頂点数を保持する配列です.

    pure auto children(Node u)

      頂点 u の子頂点を Range で返します.

  Tree!Graph tree(Graph, Node)(Graph g, Node r)

    グラフ g を元に木を作成します.

*/

unittest
{
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

  auto tr = g.tree(0);

  assert(tr.parent[0] == 0);
  assert(tr.parent[1] == 0);
  assert(tr.parent[3] == 1);

  assert(tr.depth[0] == 0);
  assert(tr.depth[1] == 1);
  assert(tr.depth[3] == 2);

  assert(tr.size[0] == 13);
  assert(tr.size[1] == 7);
  assert(tr.size[3] == 1);

  assert(equal(tr.children(0), [1, 2]));
  assert(equal(tr.children(1), [3, 4, 5]));
  assert(tr.children(3).empty);
}
