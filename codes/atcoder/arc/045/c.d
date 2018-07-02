// URL: https://beta.atcoder.jp/contests/arc045/tasks/arc045_c

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
  int n, x; readV(n, x);

  auto g = GraphW!int(n);
  foreach (_; 0..n-1) {
    int a, b, c; readV(a, b, c); --a; --b;
    g.addEdgeB(a, b, c);
  }

  auto s = new int[](n), v = new bool[](n), q = DList!int(0);
  v[0] = true;
  while (!q.empty) {
    auto a = q.front; q.removeFront();
    foreach (e; g[a].filter!(e => !v[e.dst])) {
      v[e.dst] = true;
      s[e.dst] = s[a]^e.wt;
      q.insertBack(e.dst);
    }
  }

  int[int] h;
  foreach (si; s) ++h[si];

  auto r = 0L;
  foreach (i; 0..n) {
    if ((s[i]^x) in h)
      r += h[s[i]^x];
    if (x == 0) --r;
  }

  writeln(r/2);
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
