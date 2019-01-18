// URL: https://atcoder.jp/contests/abc051/tasks/abc051_c

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
  int sx, sy, tx, ty; readV(sx, sy, tx, ty);

  auto x = tx-sx, y = ty-sy;
  auto w(dchar c, int l) { write(c.repeat.take(l)); }

  w('U', y);
  w('R', x);
  w('D', y);
  w('L', x);

  w('L', 1);
  w('U', y+1);
  w('R', x+1);
  w('D', 1);

  w('R', 1);
  w('D', y+1);
  w('L', x+1);
  w('U', 1);

  writeln;
}
