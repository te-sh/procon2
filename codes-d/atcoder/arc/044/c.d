// URL: https://atcoder.jp/contests/arc044/tasks/arc044_c

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

const nt = 10^^5, inf = 10^^9;

version(unittest) {} else
void main()
{
  int w, h, q; readV(w, h, q);
  int[] t, d, x; readC(q, t, d, x);
  --t[]; --x[];

  auto b = new int[][][](2, nt);
  foreach (i; 0..q) b[d[i]][t[i]] ~= x[i];

  auto calc(int w, int[][] b)
  {
    auto dp = new int[](w);
    foreach (i; 0..nt) {
      b[i].sort();
      foreach (xi; b[i])
        if (xi < w-1) dp[xi+1] = min(dp[xi+1], dp[xi]+1);
      foreach_reverse (xi; b[i])
        if (xi > 0) dp[xi-1] = min(dp[xi-1], dp[xi]+1);
      foreach (xi; b[i])
        dp[xi] = inf;
    }

    return dp.reduce!min;
  }

  auto r = calc(w, b[0]) + calc(h, b[1]);
  writeln(r >= inf ? -1 : r);
}
