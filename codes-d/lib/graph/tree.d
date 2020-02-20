module lib.graph.tree;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.graph.tree
import lib.graph.graph;

/**
 ** 木を表します.
 **/
struct Tree(Graph)
{
  alias Node = Graph.Node;
  /**
   ** 木の元になったグラフです.
   **/
  Graph g;
  alias g this;
  /**
   ** 根の頂点です.
   **/
  Node root;
  /**
   ** parent は頂点ごとの親の頂点を持つ配列です.
   ** dfsOrder は頂点を根からの DFS で訪れた順に並べた配列です.
   **/
  Node[] parent, dfsOrder;
  /**
   ** size は頂点ごとのその頂点を根とする部分木に含まれる頂点の数を持つ配列です.
   ** depth は頂点ごとのその頂点の根からの深さを持つ配列です.
   **/
  int[] size, depth;

  pure nothrow @safe
  {
    /**
     ** グラフ g を元にした根が r の木を返します.
     **/
    this(Graph g, Node r)
      in { assert(0 <= r && r < g.n); }
    do
    {
      this.g = g;
      this.root = r;

      parent = new Node[](n);
      depth = new int[](n);
      depth[] = -1;

      auto st = SList!UP(UP(r, r));
      while (!st.empty) {
        auto up = st.front; st.removeFront();

        parent[up.u] = up.p;
        depth[up.u] = depth[up.p] + 1;
        dfsOrder ~= up.u;

        foreach (v; g[up.u])
          if (v != up.p) st.insertFront(UP(v, up.u));
      }

      size = new int[](n);
      size[] = 1;
      foreach_reverse (u; dfsOrder.drop(1))
        size[parent[u]] += size[u];
    }

    /**
     ** 頂点 u の子を列挙して Range で返します.
     **/
    auto children(Node u) const
      in { assert(0 <= u && u < g.n); }
    do
    {
      return g[u].filter!(v => v != parent[u]);
    }
  }

  private
  {
    struct UP { Node u, p; }
  }
}

pure nothrow @safe
{
  /**
   ** グラフ g を元にした根が r の木を返します.
   **/
  auto tree(Graph, Node)(Graph g, Node r)
    in { assert(0 <= r && r < g.n); }
  do
  {
    return Tree!Graph(g, r);
  }
}
// ::::::::::::::::::::

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

  assert(equal(tr.dfsOrder, [0, 2, 6, 11, 12, 10, 1, 5, 4, 8, 9, 7, 3]));

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
