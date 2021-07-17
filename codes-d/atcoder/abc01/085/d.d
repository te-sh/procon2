// URL: https://atcoder.jp/contests/abc085/tasks/abc085_d

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
  int n, h; readV(n, h);
  int[] a, b; readC(n, a, b);

  struct S { int t, d; }
  auto s = new S[](n*2);
  foreach (i, ai; a) s[i] = S(0, ai);
  foreach (i, bi; b) s[i+n] = S(1, bi);
  s.sort!"a.d > b.d";

  auto r = 0;
  foreach (si; s) {
    if (si.t == 0) {
      writeln(r+(h+si.d-1)/si.d);
      return;
    }
    h -= si.d;
    ++r;
    if (h <= 0) {
      writeln(r);
      return;
    }
  }
}
