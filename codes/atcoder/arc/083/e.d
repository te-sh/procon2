// URL: https://beta.atcoder.jp/contests/arc083/tasks/arc083_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

const inf = 10^^9;

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] p; readA(n-1, p); p[] -= 1;
  int[] x; readA(n, x);

  auto c = new int[][](n);
  foreach (i; 1..n) c[p[i-1]] ~= i;
  auto nc = new int[](n);
  foreach (i; 0..n) nc[i] = c[i].length.to!int;

  auto y = new int[](n);
  foreach_reverse (i; 0..n) {
    auto dp = new int[][](nc[i]+1, x[i]+1);
    foreach (ref dpi; dp) dpi[] = inf;
    dp[0][0] = 0;

    foreach (j; 0..nc[i]) {
      auto xj = x[c[i][j]], yj = y[c[i][j]];
      foreach (k; 0..x[i]+1) {
        if (k >= xj) dp[j+1][k] = min(dp[j+1][k], dp[j][k-xj]+yj);
        if (k >= yj) dp[j+1][k] = min(dp[j+1][k], dp[j][k-yj]+xj);
      }
    }

    y[i] = dp[$-1].reduce!min;
    if (y[i] >= inf) {
      writeln("IMPOSSIBLE");
      return;
    }
  }

  writeln("POSSIBLE");
}