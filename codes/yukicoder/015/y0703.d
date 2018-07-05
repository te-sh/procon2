// URL: https://yukicoder.me/problems/no/703

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
  long[] a; readA(n, a);
  long[] x; readA(n, x);
  long[] y; readA(n, y);

  auto dp = new long[](n+1), cht = ConvexHullTrickSimple!long(n);

  foreach (i; 0..n) {
    cht.add(-2*x[i], dp[i]+x[i]^^2+y[i]^^2);
    dp[i+1] = cht.get(a[i]) + a[i]^^2;
  }

  writeln(dp[n]);
}

struct ConvexHullTrickSimple(T)
{
  import std.typecons;

  alias Line = Tuple!(T, T);
  Line[] deq;
  int s = 0, t = 0;

  this(size_t n)
  {
    deq = new Line[](n);
  }

  auto add(T a, T b)
  {
    auto p = Line(a, b);
    while (s+1 < t && check(deq[t-2], deq[t-1], p)) --t;
    deq[t++] = p;
  }

  auto get(T x)
  {
    while (s+1 < t && f(deq[s], x) >= f(deq[s+1], x)) ++s;
    return f(deq[s], x);
  }

  auto check(Line p1, Line p2, Line p3)
  {
    return (p2[0]-p1[0])*(p3[1]-p2[1]) >= (p2[1]-p1[1])*(p3[0]-p2[0]);
  }

  auto f(Line p, T x)
  {
    return p[0]*x+p[1];
  }
}
