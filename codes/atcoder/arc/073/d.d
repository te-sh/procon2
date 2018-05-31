// URL: https://beta.atcoder.jp/contests/abc060/tasks/arc073_b

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
  int n, wt; readV(n, wt);
  int[] w, v; readC(n, w, v);

  auto u = w.dup; u[] -= w[0];

  auto dp = new int[][][](n+1, n+1, n*3+1);
  foreach (i; 0..n)
    foreach (j; 0..n+1)
      dp[i][j][] = -1;
  dp[0][0][0] = 0;

  foreach (i; 0..n)
    foreach (j; 0..n+1)
      foreach (k; 0..n*3+1) {
        dp[i+1][j][k] = dp[i][j][k];
        if (j >= 1 && k >= u[i] && dp[i][j-1][k-u[i]] >= 0)
          dp[i+1][j][k] = max(dp[i+1][j][k], dp[i][j-1][k-u[i]]+v[i]);
      }

  auto ans = 0;
  foreach (j; 0..n+1)
    foreach (k; 0..n*3+1)
      if (j.to!long*w[0]+k <= wt)
        ans = max(ans, dp[n][j][k]);

  writeln(ans);
}
