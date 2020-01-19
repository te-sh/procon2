// URL: https://yukicoder.me/problems/no/165

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
  int n, b; readV(n, b);
  P[] p; readS(n, p);

  p.sort!"a.y<b.y";

  auto x = p.map!"a.x".array;
  int[int] zx;
  foreach (i, xi; x.sort().uniq.enumerate) zx[xi] = i.to!int;
  auto nx = zx.length.to!int;
  foreach (ref pi; p) pi.x = zx[pi.x];

  auto calc(P[] p)
  {
    auto n = p.length, s = 0;

    auto nextL(int l)
    {
      auto y = p[l].y;
      while (l < n && p[l].y == y) s -= p[l++].p;
      return l;
    }

    auto nextR(int r)
    {
      auto y = p[r].y;
      while (r < n && p[r].y == y) s += p[r++].p;
      return r;
    }

    auto l = 0, r = 0, c = 0;
    while (l < n) {
      while (s <= b) {
        c = max(c, r-l);
        if (r < n) r = nextR(r);
        else       break;
      }
      l = nextL(l);
    }

    return c;
  }

  auto r = 0;
  foreach (i; 0..nx)
    foreach (j; i..nx)
      r = max(r, calc(p.filter!(pi => i <= pi.x && pi.x <= j).array));

  writeln(r);
}

struct P { int x, y, p; }
