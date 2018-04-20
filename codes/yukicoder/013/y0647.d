// URL: https://yukicoder.me/problems/no/647

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

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