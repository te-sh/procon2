import graph;

struct Dinic(Graph)
{
  import std.algorithm, std.container;
  Graph g;
  alias g this;
  alias Node = g.Node, Wt = g.Wt;
  Wt flow = 0;

  this(Graph g, Node s, Node t)
  {
    this.g = g;
    auto adj = withRev(), level = new int[](n);

    auto levelize()
    {
      level[] = -1; level[s] = 0;

      auto q = DList!Node(s);
      while (!q.empty) {
        auto u = q.front; q.removeFront();
        if (u == t) break;
        foreach (ref e; adj[u])
          if (e.cap > e.flow && level[e.dst] < 0) {
            q.insertBack(e.dst);
            level[e.dst] = level[u] + 1;
          }
      }

      return level[t];
    }

    Wt augment(Node u, Wt cur)
    {
      if (u == t) return cur;

      foreach (ref e; adj[u]) {
        auto r = &adj[e.dst][e.rev];
        if (e.cap > e.flow && level[u] < level[e.dst]) {
          auto f = augment(e.dst, min(cur, e.cap - e.flow));
          if (f > 0) {
            e.flow += f;
            r.flow -= f;
            return f;
          }
        }
      }

      return 0;
    }

    Wt f = 0;
    while (levelize >= 0)
      while ((f = augment(s, g.inf)) > 0)
        flow += f;
  }

private:

  struct EdgeR { Node src, dst; Wt cap, flow; Node rev; }
  EdgeR[][] withRev()
  {
    auto r = new EdgeR[][](n);
    foreach (gi; g)
      foreach (e; gi) {
        r[e.src] ~= EdgeR(e.src, e.dst, e.cap, 0, cast(Node)(r[e.dst].length));
        r[e.dst] ~= EdgeR(e.dst, e.src, 0, 0, cast(Node)(r[e.src].length) - 1);
      }
    return r;
  }
}
Dinic!Graph dinic(Graph, Node)(Graph g, Node s, Node t)
{
  return Dinic!Graph(g, s, t);
}

/*

  struct Dinic(Graph)

    Dinic 法により最大フローを計算します. Graph は重みつきグラフです.

    Dinic!Graph(Graph g, Node s, Node t)

      頂点 s から頂点 t への最大フローを flow にセットします.

    Wt flow;

      最大フローを保持します.

  Dinic!Graph dinic(Graph, Node)(Graph g, Node s, Node t)

    頂点 s から頂点 t への最大フローを flow にセットします.

*/

unittest
{
  auto g = GraphW!int(5);
  g.addEdge(0, 1, 5); g.addEdge(0, 2, 2); g.addEdge(0, 3, 8);
  g.addEdge(1, 2, 3); g.addEdge(1, 4, 4);
  g.addEdge(2, 3, 4); g.addEdge(2, 4, 4);
  g.addEdge(3, 4, 6);

  assert(g.dinic(0, 4).flow == 13);
}
