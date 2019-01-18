// URL: https://atcoder.jp/contests/arc056/tasks/arc056_b

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
  int n, m, s; readV(n, m, s); --s;

  auto g = Graph!int(n);
  foreach (i; 0..m) {
    int a, b; readV(a, b); --a; --b;
    g.addEdgeB(a, b);
  }

  auto c = new int[](n);
  c[] = -1;

  struct E { int n, c; }
  auto q = heapify!"a.c < b.c"(Array!E(E(s, s)));

  while (!q.empty) {
    auto e = q.front; q.removeFront();
    if (c[e.n] >= 0) continue;
    c[e.n] = e.c;
    foreach (v; g[e.n]) q.insert(E(v, min(e.c, v)));
  }

  foreach (i, ci; c)
    if (i == ci) writeln(i+1);
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
