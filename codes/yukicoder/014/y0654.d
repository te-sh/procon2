// URL: https://yukicoder.me/problems/no/654

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, m, d; readV(n, m, d);
  int[] u, v, p, q, w; readC(m, u, v, p, q, w);
  u[] -= 1; v[] -= 1;

  auto dep = new int[][](n), arr = new int[][](n);
  foreach (i; 0..m) {
    dep[u[i]] ~= p[i];
    arr[v[i]] ~= q[i];
  }

  auto st = 0, tt = 10^^9;
  dep[0] ~= st;
  arr[n-1] ~= tt;

  foreach (i; 0..n) {
    dep[i] = dep[i].sort().uniq.array;
    arr[i] = arr[i].sort().uniq.array;
  }

  auto deph = new int[int][](n), arrh = new int[int][](n), c = 0;
  foreach (i; 0..n)
    foreach (pi; dep[i]) deph[i][pi] = c++;
  foreach (i; 0..n)
    foreach (qi; arr[i]) arrh[i][qi] = c++;

  auto g = GraphW!(int, long, 10L^^18)(c);

  foreach (i; 0..m)
    g.addEdge(deph[u[i]][p[i]], arrh[v[i]][q[i]], w[i]);

  foreach (i; 0..n)
    if (!dep[i].empty)
      foreach (j; 0..dep[i].length-1)
        g.addEdge(deph[i][dep[i][j]], deph[i][dep[i][j+1]], g.inf);

  foreach (i; 0..n-1)
    foreach (qi; arr[i]) {
      auto np = dep[i].assumeSorted.upperBound(qi+d-1);
      if (!np.empty)
        g.addEdge(arrh[i][qi], deph[i][np.front], g.inf);
    }

  foreach (i; 0..arr[n-1].length-1)
    g.addEdge(arrh[n-1][arr[n-1][i]], arrh[n-1][arr[n-1][i+1]], g.inf);

  writeln(g.dinic(deph[0][st], arrh[n-1][tt]));
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

template Dinic(Graph)
{
  import std.algorithm, std.container, std.traits;
  alias Node = TemplateArgsOf!Graph[0], Wt = TemplateArgsOf!Graph[1];

  struct EdgeR { Node src, dst; Wt cap, flow; Node rev; }

  Wt dinic(ref Graph g, Node s, Node t)
  {
    auto n = g.n, adj = withRev(g, n), level = new int[](n);

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

    Wt flow = 0, f = 0;

    while (levelize >= 0)
      while ((f = augment(s, g.inf)) > 0)
        flow += f;

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
auto dinic(G, N)(G g, N s, N t) { return Dinic!G.dinic(g, s, t); }
