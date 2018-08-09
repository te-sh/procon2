// URL: https://beta.atcoder.jp/contests/abc104/tasks/abc104_c

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
  int d, g; readV(d, g); g /= 100;
  int[] p, c; readC(d, p, c); c[] /= 100;
  
  auto m = d.iota.map!(i => (i+1)*p[i]).sum + c.sum;
  auto dp = new int[][](d+1, m+1), inf = 10^^9;
  foreach (dpi; dp) dpi[] = inf;
  dp[0][0] = 0;

  foreach (i; 0..d) {
    auto s = i+1;
    foreach (j; 0..m+1) {
      foreach (k; 0..p[i])
        if (j-k*s >= 0)
          dp[i+1][j] = min(dp[i+1][j], dp[i][j-k*s]+k);
      if (j-(p[i]*s+c[i]) >= 0)
        dp[i+1][j] = min(dp[i+1][j], dp[i][j-(p[i]*s+c[i])]+p[i]);
    }
  }

  writeln(dp[d][g..$].reduce!min);
}
