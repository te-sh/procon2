// URL: https://atcoder.jp/contests/abc119/tasks/abc119_c

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
  int n, a, b, c; readV(n, a, b, c);
  int[] l; readC(n, l);

  auto d = [a, b, c], r = 10^^9;
  foreach (i; 0..1<<(n*2)) {
    auto sl = new int[](4), sc = new int[](4);
    foreach (j; 0..n) {
      auto k = ((i>>(j*2))&3);
      sl[k] += l[j];
      ++sc[k];
    }
    if (sc[0..3].all!"a>0")
      r = min(r, 3.iota.map!(j => (d[j]-sl[j]).abs+(sc[j]-1)*10).sum);
  }

  writeln(r);
}
