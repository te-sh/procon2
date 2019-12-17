import graph;

struct Tree(Graph)
{
  import std.algorithm, std.container;
  Graph g;
  alias Node = Graph.Node;
  alias g this;
  Node root;
  Node[] par;
  int[] size, dep;

  this(Graph g, Node r) { this.g = g; rootify(r); }

  auto rootify(Node r)
  {
    this.root = r;

    par = new Node[](g.n);
    dep = new int[](g.n);
    dep[] = -1;

    struct UP { Node u, p; }
    auto st1 = SList!UP(UP(r, r));
    auto st2 = SList!UP();
    while (!st1.empty) {
      auto up = st1.front, u = up.u, p = up.p; st1.removeFront();

      par[u] = p;
      dep[u] = dep[p] + 1;

      foreach (v; g[u])
        if (v != p) {
          st1.insertFront(UP(v, u));
          st2.insertFront(UP(v, u));
        }
    }

    size = new int[](g.n);
    size[] = 1;

    while (!st2.empty) {
      auto up = st2.front, u = up.u, p = up.p; st2.removeFront();
      size[p] += size[u];
    }

    return this;
  }

  auto depth(Node u) { return dep[u]; }
  auto parent(Node u) { return par[u]; }
  auto children(Node u) { return g[u].filter!(v => v != par[u]); }
}
auto tree(G, N)(G g, N r) { return Tree!Graph(g, r); }

/*

  Tree(Graph)

    根付き木を表す構造体です. Graph は重みなしグラフです.

  Tree(g, r)

    グラフ g から r を根とする根付き木とする Tree 構造体を作成します.

  tree.depth(u)

    頂点 u の深さを返します.

  tree.parent(u)

    頂点 u の親を返します.

  tree.children(u)

    頂点 u の子を Range で返します.

  tree(g, r)

    グラフ g から r を根とする根付き木とする Tree 構造体を作成します.

*/

unittest
{
  import std.algorithm;

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

  auto t = g.tree(0);

  assert(t.parent(0) == 0);
  assert(t.parent(1) == 0);
  assert(t.parent(3) == 1);

  assert(t.depth(0) == 0);
  assert(t.depth(1) == 1);
  assert(t.depth(3) == 2);

  assert(equal(t.children(0), [1, 2]));
  assert(equal(t.children(1), [3, 4, 5]));
}
