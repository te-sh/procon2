// URL: http://codeforces.com/contest/967/problem/C

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

const inf = 10^^9;

version(unittest) {} else
void main()
{
  int n, m, cl, ce, v; readV(n, m, cl, ce, v);
  int[] l; readA(cl, l);
  int[] e; readA(ce, e);

  auto ls = l.assumeSorted, es = e.assumeSorted;

  auto calcWalk(R)(int yi, int ya, R s)
  {
    auto c = s.upperBound(yi).lowerBound(ya);
    if (!c.empty) return ya-yi;

    auto ci = s.lowerBound(yi), ca = s.upperBound(ya);
    return min(ci.empty ? inf : yi-ci.back, ca.empty ? inf : ca.front-ya)*2 + ya-yi;
  }

  int q; readV(q);
  foreach (_; 0..q) {
    int x1, y1, x2, y2; readV(x1, y1, x2, y2);
    auto yi = min(y1, y2), ya = max(y1, y2);

    auto calcTime()
    {
      if (x1 == x2) return (y1-y2).abs;

      auto tl = ls.empty ? inf : calcWalk(yi, ya, ls) + (x1-x2).abs;
      auto te = es.empty ? inf : calcWalk(yi, ya, es) + ((x1-x2).abs+v-1)/v;

      return min(tl, te);
    }

    writeln(calcTime);
  }
}
