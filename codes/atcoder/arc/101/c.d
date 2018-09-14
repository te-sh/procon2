// URL: https://beta.atcoder.jp/contests/abc107/tasks/arc101_a

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
  int n, k; readV(n, k);
  int[] x; readA(n, x);

  auto s = x.assumeSorted.trisect(0);

  auto a = s[0].array, na = a.length, b = s[2].array, nb = b.length;
  if (!s[1].empty) --k;

  a ~= 0;
  foreach (ref ai; a) ai = -ai;
  a.reverse();

  b = 0 ~ b;

  auto r = 10^^9;
  foreach (i; 0..k+1) {
    if (i > na || k-i > nb) continue;
    r = min(r, a[i]*2+b[k-i], a[i]+b[k-i]*2);
  }

  writeln(r);
}
