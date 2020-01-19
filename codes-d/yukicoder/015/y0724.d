// URL: https://yukicoder.me/problems/no/724

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
  int n; real a, b; readV(n, a, b);

  auto c = (a+b)/2, d = (a*b).sqrt, eps = 1.0e-12L;

  struct Cir
  {
    real x, y, r;
    this(real x)
    {
      this.x = x;
      y = (d^^2 * (1 - (x-c)^^2/c^^2)).sqrt;
      r = ((x-a)^^2 + y^^2).sqrt - a;
    }
  }

  Cir e;
  if (n%2 == 1) {
    e = Cir(a+b);
    n = (n-1)/2;
  } else {
    auto calc1(real x)
    {
      auto e = Cir(x);
      return e.r - e.y;
    }
    auto bs = iota(0.0L, a+b, eps).map!(x => tuple(x, calc1(x))).assumeSorted!"a[1]<b[1]";
    auto x = bs.lowerBound(tuple(0, 0)).back[0];
    e = Cir(x);
    n = n/2-1;
  }

  auto calc(Cir e, real x2)
  {
    auto e2 = Cir(x2);
    return (e2.r+e.r) - ((e2.x-e.x)^^2+(e2.y-e.y)^^2).sqrt;
  }

  foreach (_; 0..n) {
    auto bs = iota(0.0L, e.x, eps).map!(x2 => tuple(x2, calc(e, x2))).assumeSorted!"a[1]<b[1]";
    auto x2 = bs.lowerBound(tuple(0, 0)).back[0];
    e = Cir(x2);
  }

  writefln("%.6g", e.r);
}
