// URL: https://atcoder.jp/contests/abc114/tasks/abc114_c

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

  int[] s;
  foreach (d; 3..10) s ~= find753(d);

  writeln(s.assumeSorted.lowerBound(n+1).length);
}

auto find753(int d)
{
  int[] s;
  foreach (i; 0..3^^d) {
    auto r = conv3(i, d);
    if (!r.canFind(0) || !r.canFind(1) || !r.canFind(2))
      continue;
    auto j = 0;
    foreach (k, ri; r)
      j += ri.predSwitch(0, 3, 1, 5, 2, 7) * 10^^k;
    s ~= j;
  }
  return s;
}

auto conv3(int i, int d)
{
  auto r = new int[](d);
  foreach (j; 0..d) {
    r[j] = i%3;
    i /= 3;
  }
  return r;
}
