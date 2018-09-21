// URL: https://beta.atcoder.jp/contests/abc108/tasks/abc108_b

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
  int x1, y1, x2, y2; readV(x1, y1, x2, y2);
  x2 -= x1; y2 -= y1;

  auto x4 = -y2, y4 = x2;
  if (x2*y4-y2*x4 < 0) { x4 = -x4; y4 = -y4; }

  auto x3 = x2+x4, y3 = y2+y4;

  writefln("%d %d %d %d", x3+x1, y3+y1, x4+x1, y4+y1);
}
