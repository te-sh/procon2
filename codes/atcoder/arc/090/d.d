// URL: https://beta.atcoder.jp/contests/abc087/tasks/arc090_b

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);
  auto g1 = Graph!()(n), g2 = GraphW!()(n);
  foreach (_; 0..m) {
    int l, r, d; readV(l, r, d); --l; --r;
    g1.addEdge(l, r);
    g2.addEdge(l, r, d);
  }

  auto t = topologicalSort(g1), x = new int[](n); x[] = -1;
  if (t.length != n) {
    writeln("No");
    return;
  }
  foreach (ti; t) {
    foreach (e; g2[ti]) {
      if (x[ti] == -1) x[ti] = 0;
      auto nt = e.dst, nx = x[ti] + e.wt;
      if (x[nt] != -1 && x[nt] != nx) {
        writeln("No");
        return;
      }
      x[nt] = nx;
    }
  }

  writeln("Yes");
}

struct Graph(N = int)
{
  alias Node = N;
  Node n;
  Node[][] g;
  alias g this;
  this(Node n) { this.n = n; g = new Node[][](n); }
  void addEdge(Node u, Node v) { g[u] ~= v; }
  void addEdgeB(Node u, Node v) { g[u] ~= v; g[v] ~= u; }
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

auto topologicalSort(Graph)(ref Graph g)
{
  import std.container;
  alias Node = g.Node;
  auto n = cast(Node)(g.length), h = new int[](n);

  foreach (u; 0..n)
    foreach (v; g[u])
      ++h[v];

  auto st = SList!Node();
  foreach (i; 0..n)
    if (h[i] == 0) st.insertFront(i);

  Node[] ans;
  while (!st.empty()) {
    auto u = st.front; st.removeFront();
    ans ~= u;
    foreach (v; g[u]) {
      --h[v];
      if (h[v] == 0) st.insertFront(v);
    }
  }

  return ans;
}