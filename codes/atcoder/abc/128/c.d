// URL: https://atcoder.jp/contests/abc128/tasks/abc128_c

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
  int n, m; readV(n, m);
  auto s = new int[][](m);
  foreach (i; 0..m) {
    auto rd = rdsp;
    int k; pick(rd, k);
    s[i] = new int[](k);
    foreach (j; 0..k) pick(rd, s[i][j]);
    --s[i][];
  }
  int[] p; readA(m, p);

  auto r = 0;
 loop: foreach (i; 0..(1<<n)) {
    foreach (j; 0..m) {
      auto c = s[j].count!(k => ((i>>k)&1) == 1);
      if (c%2 != p[j]) continue loop;
    }
    ++r;
  }

  writeln(r);
}
