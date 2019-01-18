// URL: https://atcoder.jp/contests/abc099/tasks/abc099_d

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
  int n, c; readV(n, c);
  int[][] d; readM(c, c, d);
  int[][] a; readM(n, n, a);

  foreach (i; 0..n) a[i][] -= 1;

  auto b = new int[][](3, c);
  foreach (i; 0..n)
    foreach (j; 0..n)
      ++b[(i+j)%3][a[i][j]];

  auto calc(int[] b, int t)
  {
    auto r = 0;
    foreach (i; 0..c) r += b[i]*d[i][t];
    return r;
  }

  auto r = 10^^9;
  foreach (c0; 0..c)
    foreach (c1; 0..c)
      foreach (c2; 0..c) {
        if (c0 == c1 || c0 == c2 || c1 == c2) continue;
        r = min(r, calc(b[0], c0)+calc(b[1], c1)+calc(b[2], c2));
      }

  writeln(r);
}
