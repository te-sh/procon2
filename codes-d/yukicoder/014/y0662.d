// URL: https://yukicoder.me/problems/no/662

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
  int m = 5, k = 3;
  string[] s; int[] c; readC(m, s, c);
  auto n = new long[](k), a = new string[][](k);
  foreach (i; 0..k) {
    readV(n[i]);
    readC(n[i], a[i]);
  }

  auto u = new long[](m);
  foreach (i; 0..m) {
    auto t = a.map!(ai => ai.count(s[i]));
    u[i] = t.fold!"a*b";
  }
  u[] *= 5;

  auto v = 0.0L;
  foreach (i; 0..m) v += c[i].to!real * u[i];

  writefln("%.2f", v/n.fold!"a*b");
  foreach (i; 0..m) writeln(u[i]);
}
