// URL: https://atcoder.jp/contests/abc112/tasks/abc112_c

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
  int n; readV(n);
  struct P { int x, y, h; }
  P[] p; readS(n, p);

  auto pf = p.find!(pi => pi.h > 0);
  if (pf.empty) {
    foreach (x; 0..101)
      foreach (y; 0..101)
        if (p.all!(pi => pi.x != x && pi.y != y)) {
          writeln(x, " ", y, " ", 1);
          return;
        }
  } else {
    auto pt = pf[0];
    foreach (x; 0..101)
      foreach (y; 0..101) {
        auto h = pt.h + (x-pt.x).abs + (y-pt.y).abs;
        if (p.all!(pi => max(h - (x-pi.x).abs - (y-pi.y).abs, 0) == pi.h)) {
          writeln(x, " ", y, " ", h);
          return;
        }
      }
  }
}
