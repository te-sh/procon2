// URL: http://codeforces.com/contest/957/problem/C

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, u; readV(n, u);
  int[] e; readA(n, e);
  auto es = e.assumeSorted;

  auto y = -1.0L;
  foreach (i; 0..n-2) {
    if (e[i+2]-e[i] > u) continue;
    auto ei = e[i], ej = e[i+1];
    auto ek = es.lowerBound(ei+u+1).back;
    y = max(y, (ek-ej).to!real/(ek-ei));
  }

  if (y < 0)
    writeln(-1);
  else
    writefln("%.10f", y);
}
