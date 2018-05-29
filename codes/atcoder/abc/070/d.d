// URL: https://beta.atcoder.jp/contests/abc070/tasks/abc070_d

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
  int n; readV(n);

  auto g = GraphW!(int, long)(n);
  foreach (_; 0..n-1) {
    int a, b, c; readV(a, b, c); --a; --b;
    g.addEdgeB(a, b, c);
  }

  int q, k; readV(q, k); --k;

  auto d = new long[](n), vst = new bool[](n);

  struct VD { int v; long d; }
  auto qu = DList!int(k);
  vst[k] = true;

  while (!qu.empty) {
    auto v = qu.front; qu.removeFront();
    foreach (e; g[v].filter!(e => !vst[e.dst])) {
      d[e.dst] = d[v] + e.wt;
      vst[e.dst] = true;
      qu.insertBack(e.dst);
    }
  }

  foreach (_; 0..q) {
    int x, y; readV(x, y); --x; --y;
    writeln(d[x]+d[y]);
  }
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
