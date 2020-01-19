// URL: https://atcoder.jp/contests/abc054/tasks/abc054_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.bitmanip;

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
  int n, ma, mb; readV(n, ma, mb);
  int[] a, b, c; readC(n, a, b, c);

  auto as = a.sum, bs = b.sum;
  auto dp = new int[][][](n+1, as+1, bs+1), inf = 10^^9;
  foreach (ref dpi; dp)
    foreach (ref dpij; dpi)
      dpij[] = inf;

  dp[0][0][0] = 0;

  foreach (i; 0..n)
    foreach (j; 0..as+1)
      foreach (k; 0..bs+1) {
        dp[i+1][j][k] = dp[i][j][k];
        if (j >= a[i] && k >= b[i])
          dp[i+1][j][k] = min(dp[i+1][j][k], dp[i][j-a[i]][k-b[i]]+c[i]);
      }

  auto ans = inf;
  foreach (j; 1..as+1)
    foreach (k; 1..bs+1)
      if (j*mb == k*ma)
        ans = min(ans, dp[n][j][k]);

  writeln(ans == inf ? -1 : ans);
}
