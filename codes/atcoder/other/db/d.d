// URL: https://atcoder.jp/contests/dp/tasks/dp_d

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
  int n, t; readV(n, t);
  int[] w, v; readC(n, w, v);

  auto dp = new long[][](n+1, t+1);
  foreach (ref dpi; dp) dpi[] = -1;
  dp[0][0] = 0;

  foreach (i; 0..n)
    foreach (j; 0..t+1) {
      dp[i+1][j] = dp[i][j];
      if (j >= w[i] && dp[i][j-w[i]] >= 0)
        dp[i+1][j] = max(dp[i+1][j], dp[i][j-w[i]] + v[i]);
    }

  writeln(dp[$-1].reduce!max);
}
