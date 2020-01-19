// URL: https://atcoder.jp/contests/abc065/tasks/arc076_b

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
  int[] x, y; readC(n, x, y);

  struct T { int x, y, i; }
  auto t = new T[](n);
  foreach (i; 0..n) t[i] = T(x[i], y[i], i);

  struct R { int u, v, c; }
  R[] r;

  t.sort!"a.x < b.x";
  foreach (i; 0..n-1)
    r ~= R(t[i].i, t[i+1].i, min((t[i].x-t[i+1].x).abs, (t[i].y-t[i+1].y).abs));

  t.sort!"a.y < b.y";
  foreach (i; 0..n-1)
    r ~= R(t[i].i, t[i+1].i, min((t[i].x-t[i+1].x).abs, (t[i].y-t[i+1].y).abs));

  r.sort!"a.c < b.c";
  auto uf = UnionFind!int(n), ans = 0L;
  foreach (ri; r)
    if (!uf.isSame(ri.u, ri.v)) {
      uf.unite(ri.u, ri.v);
      ans += ri.c;
    }

  writeln(ans);
}

struct UnionFind(T)
{
  import std.algorithm, std.range;

  T[] p; // parent
  const T s; // sentinel
  const T n;
  T countForests; // number of forests
  T[] countNodes; // number of nodes in forests

  this(T n)
  {
    this.n = n;
    s = n;
    p = new T[](n);
    p[] = s;
    countForests = n;
    countNodes = new T[](n);
    countNodes[] = 1;
  }

  T opIndex(T i)
  {
    if (p[i] == s) {
      return i;
    } else {
      p[i] = this[p[i]];
      return p[i];
    }
  }

  bool unite(T i, T j)
  {
    auto pi = this[i], pj = this[j];
    if (pi != pj) {
      p[pj] = pi;
      --countForests;
      countNodes[pi] += countNodes[pj];
      return true;
    } else {
      return false;
    }
  }

  auto countNodesOf(T i) { return countNodes[this[i]]; }
  bool isSame(T i, T j) { return this[i] == this[j]; }

  auto groups()
  {
    auto g = new T[][](n);
    foreach (i; 0..n) g[this[i]] ~= i;
    return g.filter!(l => !l.empty);
  }
}
