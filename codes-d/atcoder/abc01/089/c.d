// URL: https://atcoder.jp/contests/abc089/tasks/abc089_c

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
  string[] s; readC(n, s);

  auto t = ['M', 'A', 'R', 'C', 'H'];

  auto h = new long[](5);
  foreach (si; s) {
    auto i = t.countUntil(si[0]);
    if (i >= 0) h[i]++;
  }

  auto calc(int a, int b, int c)
  {
    return h[a].to!long * h[b] * h[c];
  }

  auto r =
    calc(0, 1, 2) + calc(0, 1, 3) + calc(0, 1, 4) + calc(0, 2, 3) + calc(0, 2, 4) +
    calc(0, 3, 4) + calc(1, 2, 3) + calc(1, 2, 4) + calc(1, 3, 4) + calc(2, 3, 4);
  writeln(r);
}
