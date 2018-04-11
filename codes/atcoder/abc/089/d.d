// URL: https://beta.atcoder.jp/contests/abc089/tasks/abc089_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

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
