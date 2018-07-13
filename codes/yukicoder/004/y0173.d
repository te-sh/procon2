// URL: https://yukicoder.me/problems/no/173

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.random;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

const iter = 100_000;

version(unittest) {} else
void main()
{
  int n; real pa, pb; readV(n, pa, pb);
  int[] a; readA(n, a);
  int[] b; readA(n, b);

  a.sort();
  b.sort();

  auto calc()
  {
    auto decide(ref int[] a, real p)
    {
      if (a.length == 1) {
        auto r = a[0];
        a = [];
        return r;
      }

      auto q = uniform01;
      if (q < p) {
        auto r = a[0];
        a = a[1..$];
        return r;
      } else {
        auto i = uniform(1, a.length);
        auto r = a[i];
        a = a[0..i] ~ a[i+1..$];
        return r;
      }
    }

    auto da = a.dup, db = b.dup, sa = 0, sb = 0;

    foreach (_; 0..n) {
      auto ca = decide(da, pa), cb = decide(db, pb);
      if (ca > cb)      sa += ca+cb;
      else if (ca < cb) sb += ca+cb;
    }

    return sa > sb;
  }

  auto r = 0;
  foreach (_; 0..iter) r += calc;

  writefln("%.4f", r.to!real/iter);
}
