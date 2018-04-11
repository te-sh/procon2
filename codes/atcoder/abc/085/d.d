// URL: https://beta.atcoder.jp/contests/abc085/tasks/abc085_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

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
