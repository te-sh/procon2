// URL: https://atcoder.jp/contests/arc037/tasks/arc037_c

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
  int n; long k; readV(n, k);
  long[] a; readA(n, a);
  long[] b; readA(n, b);

  auto bs = b.sort();

  auto calc(long x)
  {
    auto r = a.map!(ai => bs.lowerBound(x/ai+1).length).sum;
    return r >= k;
  }

  auto ami = a.reduce!min, ama = a.reduce!max;
  auto s = iota(ami*b[0], ama*b[$-1]+1).map!(x => tuple(x, calc(x))).assumeSorted!"a[1]<b[1]";
  writeln(s.upperBound(tuple(0, false)).front[0]);
}
