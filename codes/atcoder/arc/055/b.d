// URL: https://atcoder.jp/contests/arc055/tasks/arc055_b

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
  int n, k; readV(n, k);

  auto dp = new real[][][](n+1, k+1, 2);
  foreach (i; 0..k+1) {
    dp[0][i][0] = 0;
    dp[0][i][1] = i == 0 ? 0 : 1;
  }

  foreach (i; 1..n+1)
    foreach (j; 0..k+1)
      foreach (m; 0..2) {
        auto p = 1.0L/(n-i+1);
        auto r = dp[i-1][j][0];
        if (j < k) r = max(r, dp[i-1][j+1][1]);
        dp[i][j][m] = (1-p) * dp[i-1][j][m] + p * r;
      }

  writefln("%.7f", dp[n][0][0]);
}
