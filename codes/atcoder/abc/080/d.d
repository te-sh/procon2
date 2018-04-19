// URL: https://beta.atcoder.jp/contests/abc080/tasks/abc080_d

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int n, c; readV(n, c);
  struct R { int s, t, c; }
  R[] r; readS(n, r);

  auto r2 = new R[][](c+1);
  foreach (ri; r) r2[ri.c] ~= ri;
  foreach (ri; r2) ri.sort!"a.s < b.s";

  auto tm = r.map!(ri => ri.t).reduce!max;
  auto u = new int[](tm*2+2);
  foreach (ri; r2)
    foreach (i, rij; ri) {
      if (i > 0 && ri[i-1].t == rij.s)
        u[rij.s*2]++;
      else
        u[rij.s*2-1]++;
      u[rij.t*2]--;
    }

  foreach (i; 1..tm*2+2) u[i] += u[i-1];
  writeln(u.reduce!max);
}
