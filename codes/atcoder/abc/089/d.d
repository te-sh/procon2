// URL: https://atcoder.jp/contests/abc089/tasks/abc089_d

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
  int h, w, d; readV(h, w, d);
  int[][] a; readM(h, w, a);

  auto hw = h*w, x = new int[](hw), y = new int[](hw);
  foreach (i; 0..h)
    foreach (j; 0..w) {
      x[a[i][j]] = i;
      y[a[i][j]] = j;
    }

  auto m = new int[](h*w+1);
  foreach (i; d+1..hw+1)
      m[i] = m[i-d] + (x[i]-x[i-d]).abs + (y[i]-y[i-d]).abs;

  int q; readV(q);
  foreach (_; 0..q) {
    int l, r; readV(l, r);
    writeln(m[r]-m[l]);
  }
}
