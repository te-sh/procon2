// URL: https://yukicoder.me/problems/no/662

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int m = 5, k = 3;
  string[] s; int[] c; readM(m, s, c);
  auto n = new long[](k), a = new string[][](k);
  foreach (i; 0..k) {
    readV(n[i]);
    readM(n[i], a[i]);
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
