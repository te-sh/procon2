// URL: https://atcoder.jp/contests/abc106/tasks/abc106_d

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
  int n, m, nq; readV(n, m, nq);

  auto t = new int[][](n+2, n+2);

  foreach (_; 0..m) {
    int l, r; readV(l, r);
    ++t[1][r];
    --t[l+1][r];
    --t[1][n+1];
    ++t[l+1][n+1];
  }

  foreach (j; 0..n+2)
    foreach (i; 0..n+1)
      t[i+1][j] += t[i][j];
  foreach (i; 0..n+2)
    foreach (j; 0..n+1)
      t[i][j+1] += t[i][j];

  foreach (_; 0..nq) {
    int p, q; readV(p, q);
    writeln(t[p][q]);
  }
}
