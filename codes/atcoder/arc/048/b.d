// URL: https://beta.atcoder.jp/contests/arc048/tasks/arc048_b

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

//          W  L  D
const t = [[1, 2, 0],
           [2, 0, 1],
           [0, 1, 2]];

version(unittest) {} else
void main()
{
  int n; readV(n);

  struct P { int r, h; }
  P[] p; readS(n, p);

  foreach (i; 0..n) --p[i].h;
  auto ps = p.dup.sort!"a.r == b.r ? a.h < b.h : a.r < b.r";

  foreach (pi; p) {
    auto w = ps.lowerBound(P(pi.r, 0)).length + ps.equalRange(P(pi.r, t[pi.h][0])).length;
    auto l = ps.upperBound(P(pi.r, 2)).length + ps.equalRange(P(pi.r, t[pi.h][1])).length;
    auto d = ps.equalRange(P(pi.r, t[pi.h][2])).length - 1;
    writeln(w, " ", l, " ", d);
  }
}
