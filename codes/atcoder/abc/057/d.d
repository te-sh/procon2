// URL: https://atcoder.jp/contests/abc057/tasks/abc057_d

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
  long[] v; readA(n, v);

  v.sort!"a>b";

  writefln("%.7f", v[0..a].sum.to!real/a);
  auto pt = pascalTriangle!long(n);

  if (v[0] > v[a-1]) {
    auto x = v.countUntil!(vi => vi == v[a-1]);
    auto y = v[x..$].count!(vi => vi == v[a-1]);
    writeln(pt[y][a-x]);
  } else {
    auto k = v.count!(vi => vi == v[0]);
    auto ans = 0L;
    foreach (i; a..min(k, b)+1) ans += pt[k][i];
    writeln(ans);
  }
}

pure T[][] pascalTriangle(T)(size_t n)
{
  auto t = new T[][](n+1);
  t[0] = new T[](1);
  t[0][0] = 1;
  foreach (i; 1..n+1) {
    t[i] = new T[](i+1);
    t[i][0] = t[i][$-1] = 1;
    foreach (j; 1..i)
      t[i][j] = t[i-1][j-1] + t[i-1][j];
  }
  return t;
}
