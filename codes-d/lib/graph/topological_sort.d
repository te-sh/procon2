module lib.graph.topological_sort;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.graph.topological_sort
import lib.graph.graph;

/**
 ** トポロジカルソートを行います.
 **/
struct TopologicalSort(Graph)
{
  alias Node = Graph.Node;
  /**
   ** 計算に使用したグラフです.
   **/
  Graph g;
  alias g this;
  /**
   ** トポロジカルソートの結果の頂点列です.
   **/
  Node[] nodes;

  /**
   ** グラフ g のトポロジカルソートを行った結果を保持する構造体を返します.
   **/
  pure nothrow @safe
  {
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
  }

  pure nothrow @nogc @safe
  {
    /**
     ** グラフに閉路があるかどうかを返します.
     **/
    bool hasCycle()
    {
      return nodes.length != n;
    }
  }
}

pure nothrow @safe
{
  /**
   ** グラフ g のトポロジカルソートを行った結果を保持する構造体を返します.
   **/
  auto topologicalSort(Graph)(Graph g)
  {
    return TopologicalSort!Graph(g);
  }
}
// ::::::::::::::::::::

unittest
{
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
