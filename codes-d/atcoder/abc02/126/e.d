// URL: https://atcoder.jp/contests/abc126/tasks/abc126_e

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

  auto uf = UnionFind(n);
  foreach (_; 0..m) {
    int x, y; readV(x, y); --x; --y;
    uf.unite(x, y);
  }

  writeln(uf.countForests);
}

struct UnionFind
{
  import std.algorithm, std.range;

  int[] p;
  const size_t n;
  const int s;
  size_t cf;
  size_t[] cn;

  this(size_t n)
  {
    this.n = n;
    s = cast(int)n;
    p = new int[](n);
    p[] = s;
    cf = n;
    cn = new size_t[](n); cn[] = 1;
  }

  bool unite(int i, int j)
  {
    auto pi = subst(i), pj = subst(j);
    if (pi != pj) {
      p[pj] = pi;
      --cf;
      cn[pi] += cn[pj];
      return true;
    } else {
      return false;
    }
  }

  bool isSame(int i, int j) { return subst(i) == subst(j); }
  @property countForests() { return cf; }
  auto countNodes(int i) { return cn[subst(i)]; }

  auto groups()
  {
    auto g = new int[][](n);
    foreach (i; 0..cast(int)n) g[subst(i)] ~= i;
    return g.filter!(l => !l.empty);
  }

private:

  int subst(int i) { return p[i] == s ? i : (p[i] = subst(p[i])); }
}
