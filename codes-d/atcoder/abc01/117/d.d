// URL: https://atcoder.jp/contests/abc117/tasks/abc117_d

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
  int n; long k; readV(n, k);
  long[] a; readA(n, a);

  if (k == 0) {
    writeln(a.sum);
    return;
  }

  auto m = 40;
  auto dp = new long[][](m+1, 2);
  foreach (ref dpi; dp) dpi[] = -1;
  dp[$-1][1] = 0;

  foreach_reverse (i; 0..m)
    foreach (j; 0..2) {
      auto d = j ? k.bit(i) : 1;
      foreach (b; 0..d+1)
        if (dp[i+1][j] >= 0)
          dp[i][j && b == k.bit(i)].maxU(dp[i+1][j] + (1L<<i)*a.count!(ai => ai.bit(i) == 1-b));
    }

  writeln(dp[0].reduce!max);
}

auto bit(long a, size_t b) { return (a>>b)&1; }
auto maxU(T)(ref T a, T b) { return a = max(a, b); }
