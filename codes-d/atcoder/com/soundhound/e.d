// URL: https://atcoder.jp/contests/soundhound2018-summer-qual/tasks/soundhound2018_summer_qual_e

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

  auto g = GraphW!int(n);
  foreach (_; 0..m) {
    int u, v, s; readV(u, v, s); --u; --v;
    g.addEdgeB(u, v, s);
  }

  auto assume(long b, long c)
  {
    if (b-c <= 0 || (b-c)%2 != 0) return false;
    auto a = (b-c)/2;
    auto d = new long[](n); d[0] = a;
    auto q = DList!int(0);
    while (!q.empty) {
      auto u = q.front; q.removeFront();
      foreach (e; g[u]) {
        auto v = e.dst;
        if (d[v]) {
          if (d[v] != e.wt-d[u]) return false;
        } else {
          d[v] = e.wt-d[u];
          if (d[v] <= 0) return false;
          q.insertBack(v);
        }
      }
    }
  
    return true;
  }

  auto vt = new bool[](n);
  auto b = new long[](n), bv = new bool[](n);
  auto c = new long[](n), cv = new bool[](n);

  cv[0] = true;
  auto q = DList!int(0);
  while (!q.empty) {
    auto u = q.front; q.removeFront();
    if (vt[u]) continue;
    vt[u] = true;

    foreach (e; g[u]) {
      auto v = e.dst;
      if (vt[v]) continue;
      if (bv[u]) {
        if (cv[v] && c[v] != e.wt-b[u]) {
          writeln(0);
          return;
        }
        c[v] = e.wt-b[u];
        cv[v] = true;
        if (bv[v]) {
          writeln(assume(b[v], c[v]) ? 1 : 0);
          return;
        }
        q.insertBack(v);
      } else {
        if (bv[v] && b[v] != e.wt-c[u]) {
          writeln(0);
          return;
        }
        b[v] = e.wt-c[u];
        bv[v] = true;
        if (cv[v]) {
          writeln(assume(b[v], c[v]) ? 1 : 0);
          return;
        }
        q.insertBack(v);
      }
    }
  }

  auto bm = 10L^^18, cm = 10L^^18;
  foreach (i; 0..n) {
    if (bv[i]) bm = min(bm, b[i]);
    if (cv[i]) cm = min(cm, c[i]);
  }

  auto r = (bm-1);
  if (cm < 0) r += cm;
  writeln(max(0, r));
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
