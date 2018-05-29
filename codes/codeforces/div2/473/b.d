// URL: http://codeforces.com/contest/959/problem/B

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, k, m; readV(n, k, m);
  string[] w; readA(n, w);
  int[] a; readA(n, a);
  auto g = new int[][](k);
  foreach (i; 0..k) g[i] = readXA!int;
  foreach (ref gi; g) gi[] -= 1;
  string[] s; readA(m, s);

  auto mc = new int[](k);
  foreach (int i, gi; g)
    mc[i] = gi.map!(gij => a[gij]).fold!min;

  auto h = new int[](n);
  foreach (int i, gi; g)
    foreach (gij; gi)
      h[gij] = mc[i];

  int[string] wg;
  foreach (int i, wi; w) wg[wi] = h[i];

  writeln(s.map!(si => wg[si].to!long).sum);
}

T[] readXA(T)()
{
  auto r = readln.splitter;
  auto x = r.front.to!size_t; r.popFront;
  auto a = new T[](x);
  foreach (i; 0..x) {
    a[i] = r.front.to!T;
    r.popFront;
  }
  return a;
}
