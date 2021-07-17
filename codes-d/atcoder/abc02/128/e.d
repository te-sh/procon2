// URL: https://atcoder.jp/contests/abc128/tasks/abc128_e

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
  int n, q; readV(n, q);
  int[] s, t, x; readC(n, s, t, x);
  int[] d; readC(q, d);

  struct A { int q, t, x; }
  A[] a;

  foreach (i; 0..n) {
    a ~= A(0, s[i]-x[i], x[i]);
    a ~= A(1, t[i]-x[i], x[i]);
  }
  foreach (i; 0..q)
    a ~= A(2, d[i], 0);

  a.sort!"a.t == b.t ? a.q < b.q : a.t < b.t";
  auto p = redBlackTree!(true, int)();

  foreach (ai; a)
    switch (ai.q) {
    case 0: p.insert(ai.x); break;
    case 1: p.removeKey(ai.x); break;
    case 2: writeln(p.empty ? -1 : p.front); break;
    default: assert(0);
    }
}
