// URL: https://beta.atcoder.jp/contests/arc055/tasks/arc055_c

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
  string s; readV(s);

  auto n = s.length.to!int;
  auto t = s.dup;
  t.reverse();

  auto sa1 = SuffixArray(s), sa2 = SuffixArray(cast(string)t);
  auto is1 = new size_t[](n), is2 = new size_t[](n);
  foreach (i; 0..n) {
    is1[sa1.x[i]] = i;
    is2[sa2.x[i]] = i;
  }

  auto lcp1 = LCP(sa1), lcp2 = LCP(sa2);
  auto st1 = sparseTable(lcp1), st2 = sparseTable(lcp2);

  auto r = 0L, a0 = is1[0], b0 = is2[0];
  foreach (i; n/2+1..n-1) {
    auto j = n-i;
    auto a1 = is1[i], b1 = is2[j];
    auto a = min(st1[min(a0, a1)+1..max(a0, a1)+1], n-i-1);
    auto b = min(st2[min(b0, b1)+1..max(b0, b1)+1], n-i-1);
    if (a+b < n-i) continue;
    r += a+b-(n-i)+1;
  }

  writeln(r);
}

struct SuffixArray
{
  import std.algorithm;

  string s;
  size_t n;
  size_t[] x;

  this(string s)
  {
    this.s = s;
    n = s.length;
    x = new size_t[](n);
    auto r = new size_t[](n), t = new size_t[](n);

    foreach (i; 0..n) r[x[i] = i] = s[i];
    for (size_t h = 1; t[n-1] != n-1; h <<= 1) {
      auto cmp(size_t i, size_t j)
      {
        if (r[i] != r[j]) return r[i] < r[j];
        return i+h < n && j+h < n ? r[i+h] < r[j+h] : i > j;
      }
      x.sort!((a, b) => cmp(a, b));
      foreach (i; 0..n-1) t[i+1] = t[i] + cmp(x[i], x[i+1]);
      foreach (i; 0..n) r[x[i]] = t[i];
    }
  }

  auto opIndex(size_t i) { return s[x[i]..$]; }
}

struct LCP
{
  import std.algorithm;

  size_t n;
  size_t[] x, rank;
  alias x this;

  this(ref SuffixArray sa)
  {
    n = sa.n;
    x = new size_t[](n);
    rank = new size_t[](n);
    foreach (i; 0..n) rank[sa.x[i]] = i;

    auto h = size_t(0);
    foreach (i; 0..n)
      if (rank[i]+1 < n) {
        auto j = sa.x[rank[i]+1];
        while (max(i, j)+h < n && sa.s[i+h] == sa.s[j+h]) ++h;
        x[rank[i]+1] = h;
        if (h > 0) --h;
      }
  }
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
