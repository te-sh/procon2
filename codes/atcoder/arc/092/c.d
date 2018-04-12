// URL: https://beta.atcoder.jp/contests/abc091/tasks/arc092_a

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a, b; readC(n, a, b);
  int[] c, d; readC(n, c, d);

  auto g = GraphW!()(n*2+2);
  foreach (i; 0..n)
    foreach (j; 0..n)
      if (a[i] < c[j] && b[i] < d[j])
        g.addEdge(i, n+j, 1);

  foreach (i; 0..n) {
    g.addEdge(n*2, i, 1);
    g.addEdge(n+i, n*2+1, 1);
  }

  auto r = g.fordFulkerson(n*2, n*2+1);
  writeln(r);
}

struct GraphW(N = int, W = int, W i = 10^^9)
{
  alias Node = N, Wt = W, inf = i;
  struct Edge { Node src, dst; Wt wt; alias cap = wt; }
  Node n;
  Edge[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Edge[][](n); }
  void addEdge(Node u, Node v, Wt w) { g[u] ~= Edge(u, v, w); }
  void addEdgeB(Node u, Node v, Wt w) { g[u] ~= Edge(u, v, w); g[v] ~= Edge(v, u, w); }
}

template FordFulkerson(Graph)
{
  import std.algorithm, std.container, std.traits;
  alias Node = TemplateArgsOf!Graph[0], Wt = TemplateArgsOf!Graph[1];

  struct EdgeR { Node src, dst; Wt cap, flow; Node rev; }

  Wt fordFulkerson(ref Graph g, Node s, Node t)
  {
    auto n = g.n, adj = withRev(g, n), visited = new bool[](n);

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

    Wt flow;

    for (;;) {
      visited[] = false;
      auto f = augment(s, g.inf);
      if (f == 0) break;
      flow += f;
    }

    return flow;
  }

  EdgeR[][] withRev(ref Graph g, Node n)
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
auto fordFulkerson(G, N)(G g, N s, N t) { return FordFulkerson!(typeof(g)).fordFulkerson(g, s, t); }
