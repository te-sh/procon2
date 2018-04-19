// URL: https://beta.atcoder.jp/contests/abc086/tasks/arc089_a

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
  int[] t, x, y; readC(n, t, x, y);

  if ((x[0]+y[0])%2 != t[0]%2 || x[0]+y[0] > t[0]) {
    writeln("No");
    return;
  }

  foreach (i; 1..n)
    if ((x[i]+y[i])%2 != t[i]%2 || (x[i]-x[i-1]).abs+(y[i]-y[i-1]).abs > t[i]-t[i-1]) {
      writeln("No");
      return;
    }

  writeln("Yes");
}
