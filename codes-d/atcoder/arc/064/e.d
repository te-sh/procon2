// URL: https://atcoder.jp/contests/arc064/tasks/arc064_c

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
  real xs, ys, xt, yt; readV(xs, ys, xt, yt);
  int n; readV(n);
  real[] x, y, r; readC(n, x, y, r);

  auto g = GraphW!(int, real, 1.0e+18L)(n+2);

  foreach (i; 0..n)
    foreach (j; i+1..n)
      g.addEdgeB(i, j, max(0, sqrt((x[i]-x[j])^^2+(y[i]-y[j])^^2)-(r[i]+r[j])));

  foreach (i; 0..n) {
    g.addEdgeB(n, i, max(0, sqrt((xs-x[i])^^2+(ys-y[i])^^2)-r[i]));
    g.addEdgeB(n+1, i, max(0, sqrt((xt-x[i])^^2+(yt-y[i])^^2)-r[i]));
  }
  g.addEdgeB(n, n+1, sqrt((xs-xt)^^2+(ys-yt)^^2));

  auto d = g.dijkstra(n);
  writefln("%.10f", d[n+1]);
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
