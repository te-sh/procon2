// URL: https://yukicoder.me/problems/no/704

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

const inf = 10L^^18;
alias SegTree = SegmentTree!(long, min);

version(unittest) {} else
void main()
{
  int n; readV(n);
  long[] a; readA(n, a);
  long[] x; readA(n, x);
  long[] y; readA(n, y);

  auto dp = new long[](n+1), st1 = new SegTree(n, inf), st2 = new SegTree(n, inf);
  foreach (i; 0..n) {
    st1[i] = dp[i]+y[i]-x[i];
    st2[i] = dp[i]+y[i]+x[i];

    auto p = x[0..i+1].assumeSorted.lowerBound(a[i]).length;
    dp[i+1] = min(st1[0..p]+a[i], st2[p..i+1]-a[i]);
  }

  writeln(dp[n]);
}

class SegmentTree(T, alias pred = "a + b")
{
  import core.bitop, std.functional;
  alias predFun = binaryFun!pred;

  const size_t n, an;
  T[] buf;
  T unit;

  this(size_t n, T unit = T.init)
  {
    this.n = n;
    this.unit = unit;
    an = n == 1 ? 1 : (1 << ((n-1).bsr + 1));
    buf = new T[](an*2);
    if (T.init != unit) buf[] = unit;
  }

  this(T[] init, T unit = T.init)
  {
    this(init.length, unit);
    buf[an..an+n][] = init[];
    foreach_reverse (i; 1..an)
      buf[i] = predFun(buf[i*2], buf[i*2+1]);
  }

  void opIndexAssign(T val, size_t i)
  {
    buf[i += an] = val;
    while (i /= 2)
      buf[i] = predFun(buf[i*2], buf[i*2+1]);
  }

  pure T opSlice(size_t l, size_t r)
  {
    l += an; r += an;
    T r1 = unit, r2 = unit;
    while (l != r) {
      if (l % 2) r1 = predFun(r1, buf[l++]);
      if (r % 2) r2 = predFun(buf[--r], r2);
      l /= 2; r /= 2;
    }
    return predFun(r1, r2);
  }

  pure T opIndex(size_t i) { return buf[i+an]; }
  pure size_t opDollar() { return n; }
}
