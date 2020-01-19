// URL: https://atcoder.jp/contests/arc052/tasks/arc052_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);
  int[] c, a, b; readC(m, c, a, b);

  auto g1 = GraphW!int(n);
  foreach (i; 0..m)
    g1.addEdgeB(a[i], b[i], c[i]);
  auto d = g1.dijkstra(0);

  auto e = new int[](n);
  foreach (i; 0..n)
    e[i] = iota(0, n).map!(j => j*(j+1)/2).assumeSorted.lowerBound(n+d[i]*(d[i]+1)/2).length.to!int;

  auto dist = new int[][](n);
  foreach (i; 0..n) {
    dist[i] = new int[](e[i]-d[i]);
    dist[i][] = 10^^9;
  }
  dist[0][0] = 0;

  struct VW { int dst, wt, b; }
  auto q = heapify!("a.wt > b.wt")(Array!VW(VW(0, 0, 0)));
  while (!q.empty) {
    auto u = q.front; q.removeFront();
    foreach (f; g1[u.dst]) {
      auto w = u.wt + (f.wt == 0 ? 1 : 0);
      auto nb = u.b + (f.wt == 0 ? 0 : 1);
      if (nb < e[f.dst] && dist[f.dst][nb-d[f.dst]] > w) {
        dist[f.dst][nb-d[f.dst]] = w;
        q.insert(VW(f.dst, w, nb));
      }
    }
  }

  foreach (i; 0..n) {
    auto s = 10^^9;
    foreach (j; d[i]..e[i])
      s = min(s, dist[i][j-d[i]]+j*(j+1)/2);
    writeln(s);
  }
}

class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  T opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  size_t opDollar() { return n; }
}
auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }

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

template Dijkstra(Graph)
{
  import std.array, std.container, std.traits;
  alias Node = TemplateArgsOf!Graph[0], Wt = TemplateArgsOf!Graph[1];
  alias Edge = Graph.Edge;

  void dijkstra(ref Graph g, Node s, out Wt[] dist, out Node[] prev)
  {
    auto n = g.n, sent = n;

    dist = new Wt[](n);
    dist[] = g.inf;
    dist[s] = 0;

    prev = new Node[](n);
    prev[] = sent;

    auto q = heapify!("a.wt > b.wt")(Array!Edge(Edge(sent, s, 0)));
    while (!q.empty) {
      auto e = q.front; q.removeFront();
      if (prev[e.dst] != sent) continue;
      prev[e.dst] = e.src;
      foreach (f; g[e.dst]) {
        auto w = e.wt + f.wt;
        if (dist[f.dst] > w) {
          dist[f.dst] = w;
          q.insert(Edge(f.src, f.dst, w));
        }
      }
    }
  }

  auto dijkstra(ref Graph g, Node s)
  {
    Wt[] dist;
    Node[] prev;
    dijkstra(g, s, dist, prev);
    return dist;
  }
}
auto dijkstra(G, N)(G g, N s) { return Dijkstra!G.dijkstra(g, s); }
