// URL: http://codeforces.com/contest/967/problem/D

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

struct CI { int c, i; }

version(unittest) {} else
void main()
{
  int n, x1, x2; readV(n, x1, x2);
  int[] c; readA(n, c);

  auto ci = new CI[](n);
  foreach (i; 0..n) ci[i] = CI(c[i], i+1);
  auto cis = ci.sort!"a.c < b.c";

  auto r1 = calc(n, x1, x2, cis);
  if (r1[0] > 0) {
    put(r1[0], r1[1], r1[2], r1[3]);
    return;
  }

  auto r2 = calc(n, x2, x1, cis);
  if (r2[0] > 0) {
    put(r2[1], r2[0], r2[3], r2[2]);
    return;
  }

  writeln("No");
}

auto calc(R)(int n, int x1, int x2, R cis)
{
  auto calcK2()
  {
    foreach (k2; 1..n) {
      if (cis[$-k2].c >= (x2+k2-1)/k2) return k2;
    }
    return 0;
  }

  auto k2 = calcK2;
  if (k2 == 0) return tuple(0, 0, cast(int[])[], cast(int[])[]);

  foreach (k1; 1..n) {
    auto r = cis.upperBound(CI((x1+k1-1)/k1-1, 0));
    if (r.length >= k1+k2) {
      auto s = r.map!"a.i".array;
      return tuple(k1, k2, s[0..k1], s[$-k2..$]);
    }
  }

  return tuple(0, 0, cast(int[])[], cast(int[])[]);
}

auto put(int k1, int k2, int[] r1, int[] r2)
{
  writeln("Yes");
  writeln(k1, " ", k2);

  foreach (i; 0..k1) {
    write(r1[i]);
    if (i < k1-1) write(" ");
  }
  writeln;

  foreach (i; 0..k2) {
    write(r2[i]);
    if (i < k2-1) write(" ");
  }
}
