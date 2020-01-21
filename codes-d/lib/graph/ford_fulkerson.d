module lib.graph.ford_fulkerson;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.graph.ford_fulkerson
import lib.graph.graph;

/**
 ** Ford-Fulkerson 法で指定された2頂点間の最大流を計算します.
 **/
struct FordFulkerson(Graph)
{
  /**
   ** 計算に使用したグラフです.
   **/
  Graph g;
  alias g this;
  alias Node = g.Node, Wt = g.Wt;
  /**
   ** 指定された2頂点間の最大流です.
   **/
  Wt flow = 0;

  /**
   ** グラフ g の頂点 s から頂点 t への最大流を Ford-Fulkerson 法で
   ** 計算した結果を保持する構造体を返します.
   **/
  this(Graph g, Node s, Node t)
  {
    this.g = g;
    auto adj = withRev(), visited = new bool[](n);

    Wt augment(Node u, Wt cur)
    {
      if (u == t) return cur;
      visited[u] = true;
      foreach (ref e; adj[u]) {
        if (!visited[e.dst] && e.cap > e.flow) {
          auto f = augment(e.dst, min(e.cap - e.flow, cur));
          if (f > 0) {
            e.flow += f;
            adj[e.dst][e.rev].flow -= f;
            return f;
          }
        }
      }
      return 0;
    }

    for (;;) {
      visited[] = false;
      auto f = augment(s, g.inf);
      if (f == 0) break;
      flow += f;
    }
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
/**
 ** グラフ g の頂点 s から頂点 t への最大流を Ford-Fulkerson 法で
 ** 計算した結果を保持する構造体を返します.
 **/
FordFulkerson!Graph fordFulkerson(Graph, Node)(Graph g, Node s, Node t)
{
  return FordFulkerson!(Graph)(g, s, t);
}
// ::::::::::::::::::::

unittest
{
  auto g = GraphW!int(5);
  g.addEdge(0, 1, 5); g.addEdge(0, 2, 2); g.addEdge(0, 3, 8);
  g.addEdge(1, 2, 3); g.addEdge(1, 4, 4);
  g.addEdge(2, 3, 4); g.addEdge(2, 4, 4);
  g.addEdge(3, 4, 6);

  assert(g.fordFulkerson(0, 4).flow == 13);
}
