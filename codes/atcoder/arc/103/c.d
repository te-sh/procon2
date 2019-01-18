// URL: https://atcoder.jp/contests/abc111/tasks/arc103_a

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
  int[] v; readA(n, v);

  auto m = n/2, v1 = new int[](m), v2 = new int[](m);
  foreach (i; 0..m) {
    v1[i] = v[i*2];
    v2[i] = v[i*2+1];
  }

  int[int] h1, h2;
  foreach (i; 0..m) {
    ++h1[v1[i]];
    ++h2[v2[i]];
  }

  auto p1 = h1.byPair.array, p2 = h2.byPair.array;
  p1.sort!"a[1]>b[1]";
  p2.sort!"a[1]>b[1]";

  if (p1[0][0] != p2[0][0]) {
    writeln(n-p1[0][1]-p2[0][1]);
  } else {
    p1 ~= tuple(-1, 0);
    p2 ~= tuple(-1, 0);
    if (p1[1][1]+p2[0][1] > p1[0][1]+p2[1][1])
      writeln(n-p1[1][1]-p2[0][1]);
    else
      writeln(n-p1[0][1]-p2[1][1]);
  }
}
