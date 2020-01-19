// URL: https://yukicoder.me/problems/no/760

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
  real xa, ya, ta; readV(xa, ya, ta); ta *= PI/180;
  real x11, y11; readV(x11, y11);
  real x12, y12; readV(x12, y12);
  real x21, y21; readV(x21, y21);
  real x22, y22; readV(x22, y22);

  auto tb = atan2(y12-y11, x12-x11)-atan2(y22-y21, x22-x21)+ta;
  auto xb = x11-(x21-xa)*cos(tb-ta)+(y21-ya)*sin(tb-ta);
  auto yb = y11-(x21-xa)*sin(tb-ta)-(y21-ya)*cos(tb-ta);
  writefln("%.6f %.6f %.6f", xb, yb, tb/PI*180);
}
