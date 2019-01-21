// URL: https://atcoder.jp/contests/abc114/tasks/abc114_d

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

  auto f = new int[](n+1);
  foreach (i; 1..n+1) {
    while (i > 1) {
      foreach (j; 2..i+1)
        while (i%j == 0) {
          ++f[j];
          i /= j;
        }
    }
  }

  auto c = f.filter!"a >= 2".array, m = c.length, r = 0;

  foreach (i; 0..m)
    foreach (j; 0..m)
      foreach (k; j+1..m) {
        if (i != j && i != k && c[i] >= 2 && c[j] >= 4 && c[k] >= 4)
          ++r;
      }

  foreach (i; 0..m)
    foreach (j; 0..m) {
      if (i != j && c[i] >= 2 && c[j] >= 24)
        ++r;
      if (i != j && c[i] >= 4 && c[j] >= 14)
        ++r;
    }

  foreach (i; 0..m)
    if (c[i] >= 74)
      ++r;

  writeln(r);
}
