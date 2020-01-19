// URL: https://atcoder.jp/contests/abc109/tasks/abc109_d

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
  int h, w; readV(h, w);
  int[][] a; readM(h, w, a);

  auto i2p(int p)
  {
    auto i = p/w, j = p%w;
    return tuple(i, i%2 == 0 ? j : w-j-1);
  }

  int[] o;
  foreach (i; 0..h*w) {
    auto p = i2p(i);
    if (a[p[0]][p[1]]%2 == 1) o ~= i;
  }

  int[] m;

  foreach (b; 0..o.length/2) {
    auto i1 = o[b*2], i2 = o[b*2+1];
    foreach (i; i1..i2) m ~= i;
  }

  writeln(m.length);
  foreach (mi; m) {
    auto p1 = i2p(mi), p2 = i2p(mi+1);
    writefln("%d %d %d %d", p1[0]+1, p1[1]+1, p2[0]+1, p2[1]+1);
  }
}