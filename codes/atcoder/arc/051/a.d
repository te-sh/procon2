// URL: https://beta.atcoder.jp/contests/arc051/tasks/arc051_a

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
  int x1, y1, r; readV(x1, y1, r);
  int x2, y2, x3, y3; readV(x2, y2, x3, y3);
  x2 -= x1; y2 -= y1; x3 -= x1; y3 -= y1;

  writeln(x2 > -r || y2 > -r || x3 < r || y3 < r ? "YES" : "NO");

  auto x22 = x2^^2, y22 = y2^^2, x32 = x3^^2, y32 = y3^^2, r2 = r^^2;
  writeln(x22+y22 > r2 || x22+y32 > r2 || x32+y22 > r2 || x32+y32 > r2 ? "YES" : "NO");
}
