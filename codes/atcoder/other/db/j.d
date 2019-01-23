// URL: https://atcoder.jp/contests/dp/tasks/dp_j

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
  int[] a; readA(n, a);

  auto c = new int[](4);
  foreach (ai; a) ++c[ai];

  auto dp = new double[][][](n+1, n+1, n+1);
  dp[0][0][0] = 0;
  foreach (i3; 0..n+1)
    foreach (i2; 0..n-i3+1)
      foreach (i1; 0..n-i3-i2+1)
        if (i1 > 0 || i2 > 0 || i3 > 0) {
          dp[i1][i2][i3] = 1;
          if (i1 > 0) dp[i1][i2][i3] += dp[i1-1][i2][i3] * i1/n;
          if (i2 > 0) dp[i1][i2][i3] += dp[i1+1][i2-1][i3] * i2/n;
          if (i3 > 0) dp[i1][i2][i3] += dp[i1][i2+1][i3-1] * i3/n;
          dp[i1][i2][i3] /= (1-(n-i1-i2-i3).to!double/n);
        }

  writefln("%.10f", dp[c[1]][c[2]][c[3]]);
}
