// URL: https://yukicoder.me/problems/no/753

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
  const n = 16;
  int[][] a; readM(n, n, a);

  foreach (i; 0..n)
    foreach (j; i+1..n)
      a[i][j] = a[j][i] = a[i][j] == 1 ? i : j;

  auto b = new int[][](3), c = new int[][](1<<n);
  foreach (i; 0..1<<n) {
    auto j = i.popcnt;
    if (j.popcnt == 1) {
      if (j.bsf < 3)
        b[j.bsf] ~= i;
      if (j.bsf < 4)
        foreach (k; 0..n)
          if (i.bitTest(k)) c[i] ~= k;
    }
  }

  auto dp = new long[][](1<<n, n);
  foreach (bi; b[0]) dp[bi][bi.bsf] = 1;

  foreach (k; 0..3)
    foreach (bi; b[k])
      foreach (bj; b[k])
        if (!(bi&bj))
          foreach (ci; c[bi])
            foreach (cj; c[bj])
              dp[bi|bj][a[ci][cj]] += dp[bi][ci] * dp[bj][cj];

  foreach (i; 0..1<<n)
    if (i.popcnt == 8) {
      auto j = i.bitComp(0, 16);
      foreach (ci; c[i])
        foreach (cj; c[j])
          dp[i|j][a[ci][cj]] += dp[i][ci] * dp[j][cj];
    }

  foreach (i; 0..n)
    writeln(dp[$-1][i]);
}

pragma(inline) {
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  pure T bitSet(T)(T n, size_t s, size_t e) { return n | ((T(1) << e) - 1) & ~((T(1) << s) - 1); }
  pure T bitReset(T)(T n, size_t s, size_t e) { return n & (~((T(1) << e) - 1) | ((T(1) << s) - 1)); }
  pure T bitComp(T)(T n, size_t s, size_t e) { return n ^ ((T(1) << e) - 1) & ~((T(1) << s) - 1); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
}
