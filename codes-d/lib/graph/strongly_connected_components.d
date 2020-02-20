module lib.graph.strongly_connected_components;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.graph.strongly_connected_components
import lib.graph.graph;

/**
 ** Kosaraju 法による強連結成分分解を行います.
 **/
struct StronglyConnectedComponentsKosaraju(Graph)
{
  alias Node = Graph.Node;
  /**
   ** 計算に使用したグラフです.
   **/
  Graph g;
  alias g this;
  /**
   ** 強連結成分ごとの頂点の配列を保持する配列です.
   **/
  Node[][] comps;

  pure nothrow @safe
  {
    /**
     ** グラフ g の Kosaraju 法による強連結成分分解の結果を保持する構造体を返します.
     **/
    this(Graph g)
    {
      this.g = g;

      auto rdj = Graph(n), visited = new bool[](n);
      foreach (u; 0..n)
        foreach (v; g[u])
          rdj.addEdge(v, u);

      auto dfs(Node s, Graph adj)
      {
        auto q = SList!Node(s);
        visited[s] = true;
        Node[] comp;
        while (!q.empty) {
          auto u = q.front; q.removeFront();
          foreach (v; adj[u])
            if (!visited[v]) {
              visited[v] = true;
              q.insertFront(v);
            }
          comp ~= u;
        }
        comp.reverse();
        return comp;
      }

      Node[] ord;
      foreach (u; 0..n) if (!visited[u]) ord ~= dfs(u, g);
      visited[] = false;
      foreach_reverse (u; ord) if (!visited[u]) comps ~= dfs(u, rdj);
    }
  }
}

pure nothrow @safe
{
  /**
   ** グラフ g の Kosaraju 法による強連結成分分解の結果を保持する構造体を返します.
   **/
  auto stronglyConnectedComponentsKosaraju(Graph)(Graph g)
  {
    return StronglyConnectedComponentsKosaraju!Graph(g);
  }
}

/**
 ** Gabow 法による強連結成分分解を行います.
 **/
struct StronglyConnectedComponentsGabow(Graph)
{
  alias Node = Graph.Node;
  /**
   ** 計算に使用したグラフです.
   **/
  Graph g;
  alias g this;
  /**
   ** 強連結成分ごとの頂点の配列を保持する配列です.
   **/
  Node[][] comps;

  pure nothrow @safe
  {
    /**
     ** グラフ g の Gabow 法による強連結成分分解の結果を保持する構造体を返します.
     **/
    this(Graph g)
    {
      this.g = g;
      Node[] i = new Node[](n);
      auto s = SList!Node(), b = SList!Node(), ns = Node(0);

      void dfs(Node u)
      {
        b.insert(i[u] = ns);
        s.insert(u); ++ns;
        foreach (v; g[u]) {
          if (!i[v]) dfs(v);
          else while (i[v] < b.front) b.removeFront;
        }
        if (i[u] == b.front) {
          comps ~= [[]];
          b.removeFront;
          while (i[u] < ns) {
            comps[$-1] ~= s.front;
            i[s.front] = n + cast(Node)comps.length;
            s.removeFront; --ns;
          }
        }
      }

      foreach (u; 0..n) if (!i[u]) dfs(u);
    }
  }
}

pure nothrow @safe
{
  /**
   ** グラフ g の Gabow 法による強連結成分分解の結果を保持する構造体を返します.
   **/
  auto stronglyConnectedComponentsGabow(Graph)(Graph g)
  {
    return StronglyConnectedComponentsGabow!Graph(g);
  }
}
// ::::::::::::::::::::

unittest
{
  auto g = Graph(7);
  g.addEdge(0, 1);
  g.addEdge(1, 2);
  g.addEdge(2, 0);
  g.addEdge(2, 3);
  g.addEdge(3, 4);
  g.addEdge(4, 3);
  g.addEdge(4, 5);
  g.addEdge(4, 6);
  assert(equal(g.stronglyConnectedComponentsKosaraju.comps, [[1, 2, 0], [4, 3], [6], [5]]));
  assert(equal(g.stronglyConnectedComponentsGabow.comps, [[5], [6], [4, 3], [0, 2, 1]]));
}
