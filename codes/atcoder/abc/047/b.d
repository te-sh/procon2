// URL: https://beta.atcoder.jp/contests/abc047/tasks/abc047_b

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
  int w, h, n; readV(w, h, n);

  auto x1 = 0, x2 = w, y1 = 0, y2 = h;
  foreach (_; 0..n) {
    int x, y, a; readV(x, y, a);
    switch (a) {
    case 1: x1 = max(x1, x); break;
    case 2: x2 = min(x2, x); break;
    case 3: y1 = max(y1, y); break;
    case 4: y2 = min(y2, y); break;
    default: assert(0);
    }
  }

  writeln(x2<x1 || y2<y1 ? 0 : (x2-x1)*(y2-y1));
}
