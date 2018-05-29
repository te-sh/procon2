// URL: https://beta.atcoder.jp/contests/abc095/tasks/arc096_b

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
  int n; long c; readV(n, c);
  long[] x; int[] v; readC(n, x, v);

  auto c1 = new long[](n);
  c1[n-1] = v[n-1] - (c-x[n-1]);
  foreach_reverse (i; 0..n-1)
    c1[i] = c1[i+1] + v[i] - (x[i+1]-x[i]);

  auto mc1 = new long[](n);
  mc1[n-1] = c1[n-1];
  foreach_reverse (i; 0..n-1)
    mc1[i] = max(c1[i], mc1[i+1]);

  auto c2 = new long[](n);
  c2[0] = v[0] - x[0];
  foreach (i; 1..n)
    c2[i] = c2[i-1] + v[i] - (x[i]-x[i-1]);

  auto mc2 = new long[](n);
  mc2[0] = c2[0];
  foreach (i; 1..n)
    mc2[i] = max(c2[i], mc2[i-1]);

  auto ans = max(0L, mc1.reduce!max, mc2.reduce!max);
  foreach (i; 0..n-1) {
    ans = max(ans, c2[i] - x[i] + mc1[i+1]);
    ans = max(ans, c1[n-i-1] - (c-x[n-i-1]) + mc2[n-i-2]);
  }

  writeln(ans);
}
