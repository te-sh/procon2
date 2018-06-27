// URL: https://beta.atcoder.jp/contests/arc049/tasks/arc049_b

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
  int n; readV(n);
  int[] x, y, c; readC(n, x, y, c);

  auto calc(real t)
  {
    foreach (i; 0..n)
      foreach (j; i+1..n) {
        auto d1 = t/c[i];
        auto x1 = x[i]-d1, y1 = y[i]-d1, x2 = x[i]+d1, y2 = y[i]+d1;
        auto d2 = t/c[j];
        auto x3 = x[j]-d2, y3 = y[j]-d2, x4 = x[j]+d2, y4 = y[j]+d2;

        if (inner(x1, y1, x3, y3, x4, y4) ||
            inner(x1, y2, x3, y3, x4, y4) ||
            inner(x2, y1, x3, y3, x4, y4) ||
            inner(x2, y2, x3, y3, x4, y4) ||
            inner(x3, y3, x1, y1, x2, y2) ||
            inner(x3, y4, x1, y1, x2, y2) ||
            inner(x4, y3, x1, y1, x2, y2) ||
            inner(x4, y4, x1, y1, x2, y2))
          continue;

        return false;
      }

    return true;
  }

  auto bs = iota(0.0L, 1.0e+9L, 1.0e-5L).map!(t => tuple(t, calc(t))).assumeSorted!"a[1]<b[1]";
  writefln("%.5f", bs.upperBound(tuple(0.0L, false)).front[0]);
}

auto inner(real x, real y, real x1, real y1, real x2, real y2)
{
  return x1 <= x && x <= x2 && y1 <= y && y <= y2;
}
