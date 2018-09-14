// URL: https://beta.atcoder.jp/contests/abc107/tasks/abc107_b

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
  string[] a; readC(h, a);

  auto sh = new bool[](h), sw = new bool[](w);
  foreach (i; 0..h)
    if (a[i].all!(ai => ai == '.'))
      sh[i] = true;
  foreach (j; 0..w)
    if (a.map!(ai => ai[j]).all!(aj => aj == '.'))
      sw[j] = true;

  foreach (i; 0..h) {
    if (sh[i]) continue;
    foreach (j; 0..w) {
      if (sw[j]) continue;
      write(a[i][j]);
    }
    writeln;
  }
}
