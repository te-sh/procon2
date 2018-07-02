// URL: https://beta.atcoder.jp/contests/arc045/tasks/arc045_b

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
  int[] s, t; readC(m, s, t); --s[];

  auto a = new int[](n+1);
  foreach (i; 0..m) {
    ++a[s[i]];
    --a[t[i]];
  }
  foreach (i; 1..n+1) a[i] += a[i-1];

  auto st = a.sparseTable;
  int[] r;
  foreach (i; 0..m)
    if (st[s[i]..t[i]] >= 2) r ~= i+1;

  writeln(r.length);
  foreach (ri; r) writeln(ri);
}

class SparseTable(alias pred, T)
{
  import std.algorithm, std.functional;
  alias predFun = binaryFun!pred;

  size_t[] logTable;
  size_t[][] rmq;
  size_t n;
  T[] a;

  this(T[] a)
  {
    this.a = a;
    this.n = a.length;

    logTable = new size_t[n+1];
    foreach (i; 2..n+1)
      logTable[i] = logTable[i>>1]+1;

    rmq = new size_t[][](logTable[n]+1, n);

    foreach (i; 0..n) rmq[0][i] = i;

    for (size_t k = 1; (1<<k) < n; ++k)
      for (size_t i = 0; i+(1<<k) <= n; ++i) {
        auto x = rmq[k-1][i];
        auto y = rmq[k-1][i+(1<<k-1)];
        rmq[k][i] = predFun(a[x], a[y]) == a[x] ? x : y;
      }
  }

  pure T opSlice(size_t l, size_t r)
  {
    auto k = logTable[r-l-1];
    auto x = rmq[k][l];
    auto y = rmq[k][r-(1<<k)];
    return predFun(a[x], a[y]);
  }

  pure size_t opDollar() { return n; }
}
auto sparseTable(alias pred = "a < b ? a : b", T)(T[] a) { return new SparseTable!(pred, T)(a); }
