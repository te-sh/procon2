// URL: http://codeforces.com/contest/975/problem/D

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
  int n, a, b; readV(n, a, b);
  int[] x, vx, vy; readC(n, x, vx, vy);

  struct V { long n, d; }
  auto v = new V[](n);
  foreach (i; 0..n)
    v[i] = V(a.to!long*vx[i]-vy[i], a.to!long*vy[i]+vx[i]);

  auto vs = v.sort!"a.n == b.n ? a.d < b.d : a.n < b.n";

  auto ans = 0L;
  foreach (vi; v) {
    ans += vs.upperBound(V(vi.n, long.min)).lowerBound(V(vi.n, long.max)).length;
    ans -= vs.equalRange(vi).length;
  }

  writeln(ans);
}
