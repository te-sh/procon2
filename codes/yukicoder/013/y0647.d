// URL: https://yukicoder.me/problems/no/647

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  struct M { int x, y; }
  int n; readV(n);
  M[] f; readS(n, f);
  int m; readV(n);
  M[] s; readS(n, s);

  auto c = new int[](n);
  foreach (fi; f)
    foreach (i, si; s)
      if (fi.x >= si.x && fi.y <= si.y) ++c[i];

  auto ma = c.maxElement;
  if (ma == 0) {
    writeln(0);
    return;
  }
  foreach (i, ci; c)
    if (ci == ma) writeln(i+1);
}
