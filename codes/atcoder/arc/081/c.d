// URL: https://beta.atcoder.jp/contests/abc071/tasks/arc081_a

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  int[int] h;
  foreach (ai; a) h[ai]++;

  auto u = h.keys.sort!"a>b".filter!(ai => h[ai] >= 2).array;

  if (u.length == 0 || u.length == 1 && h[u[0]] < 4)
    writeln(0);
  else if (h[u[0]] >= 4)
    writeln(u[0].to!long^^2);
  else
    writeln(u[0].to!long*u[1]);
}
