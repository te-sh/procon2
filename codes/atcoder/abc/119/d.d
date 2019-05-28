// URL: https://atcoder.jp/contests/abc119/tasks/abc119_d

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
  int a, b, q; readV(a, b, q);
  long[] s; readC(a, s);
  long[] t; readC(b, t);

  auto ss = s.assumeSorted, ts = t.assumeSorted;

  auto nearest(R)(long x, R y, bool d)
  {
    if (d) {
      auto r = y.lowerBound(x);
      return !r.empty ? r.back : -1;
    } else {
      auto r = y.upperBound(x);
      return !r.empty ? r.front : -1;
    }
  }

  auto calc(R)(long x, R s, R t)
  {
    auto r = 10L^^18;

    foreach (i; 0..4) {
      auto x1 = nearest(x, s, i&1);
      if (x1 == -1) continue;
      auto x2 = nearest(x1, t, (i>>1)&1);
      if (x2 == -1) continue;
      r = min(r, (x-x1).abs+(x1-x2).abs);
    }

    return r;
  }

  foreach (_; 0..q) {
    long x; readV(x);
    writeln(min(calc(x, ss, ts), calc(x, ts, ss)));
  }
}
