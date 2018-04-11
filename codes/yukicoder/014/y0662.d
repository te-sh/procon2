// URL: https://yukicoder.me/problems/no/662

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

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
