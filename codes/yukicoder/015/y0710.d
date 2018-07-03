// URL: https://yukicoder.me/problems/no/710

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
  int n; readV(n);
  int[] a, b; readC(n, a, b);

  auto sa = a.sum, dp = new int[][](n+1, sa+1);
  foreach (i; 0..n+1) dp[i][] = 10^^6;
  dp[0][0] = 0;

  foreach (i; 0..n)
    foreach (t; 0..sa+1) {
      dp[i+1][t] = dp[i][t]+b[i];
      if (t >= a[i])
        dp[i+1][t] = min(dp[i+1][t], dp[i][t-a[i]]);
    }

  auto r = 10^^6;
  foreach (t; 0..sa+1)
    r = min(r, max(t, dp[n][t]));

  writeln(r);
}
