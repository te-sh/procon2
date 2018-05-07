// URL: https://yukicoder.me/problems/no/678

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
  int n, bl, br; readV(n, bl, br);

  struct E { int l, u, r, d, i; bool a; }
  auto e = new E[](n);
  foreach (i; 0..n) {
    int l, u, r, d; readV(l, u, r, d);
    e[i] = E(l, u, r, d, i, false);
  }

  e.sort!"a.d > b.d";
  auto a = new int[](1281), ans = 0;
  a[] = 1;

  foreach (ref ei; e) {
    if (ei.r < bl || ei.l > br) continue;
    auto l = max(bl, ei.l), r = min(br, ei.r);
    if (a[l..r+1].sum) ei.a = true;
    a[l..r+1][] = 0;
  }

  e.sort!"a.i < b.i";

  foreach (ei; e)
    writeln(ei.a ? 1 : 0);
}
