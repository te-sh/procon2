module lib.graph.strongly_connected_components;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import lib.graph.graph;

struct StronglyConnectedComponentsKosaraju(Graph)
{
  Graph g;
  alias g this;
  alias Node = g.Node;
  Node[][] comps;

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
StronglyConnectedComponentsKosaraju!Graph stronglyConnectedComponentsKosaraju(Graph)(Graph g)
{
  return StronglyConnectedComponentsKosaraju!Graph(g);
}

struct StronglyConnectedComponentsGabow(Graph)
{
  Graph g;
  alias g this;
  alias Node = g.Node;
  Node[][] comps;

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
StronglyConnectedComponentsGabow!Graph stronglyConnectedComponentsGabow(Graph)(Graph g)
{
  return StronglyConnectedComponentsGabow!Graph(g);
}

/*

  struct StronglyConnectedComponentsKosaraju(Graph)

    Kosaraju 法による強連結成分分解を行います.

    StronglyConnectedComponentsKosaraju(Graph)(Graph g)

      グラフ g を元に強連結成分分解を行います.

    Node[][] comps

      強連結成分分解の結果を保持する配列です.

  struct StronglyConnectedComponentsGabow(Graph)

    Gabow 法による強連結成分分解を行います.

    StronglyConnectedComponentsGabow(Graph)(Graph g)

      グラフ g を元に強連結成分分解を行います.

    Node[][] comps

      強連結成分分解の結果を保持する配列です.

*/

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
