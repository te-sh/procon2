// URL: https://atcoder.jp/contests/arc061/tasks/arc061_c

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
  int[] p, q, c; readC(m, p, q, c); p[] -= 1; q[] -= 1;
 
  alias SC = Tuple!(int, int);
  auto sc = new SC[](m*2);
  foreach (i; 0..m) {
    sc[i*2]   = SC(p[i], c[i]);
    sc[i*2+1] = SC(q[i], c[i]);
  }
  int[SC] h;
  foreach (i, sci; sc.sort().uniq.enumerate) h[sci] = i.to!int+n;
  auto nh = h.length.to!int;
 
  auto g = GraphW!int(n+nh);
  foreach (i; 0..m) g.addEdgeB(h[SC(p[i], c[i])], h[SC(q[i], c[i])], 0);
  foreach (sci, v; h) g.addEdgeB(sci[0], v, 1);
 
  auto d = g.dijkstra(0);
  writeln(d[n-1] >= g.inf ? -1 : d[n-1]/2);
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
