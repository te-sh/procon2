// URL: https://beta.atcoder.jp/contests/abc102/tasks/arc100_b

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
  int[] a; readA(n, a);

  auto cl = new long[](n), cr = new long[](n);
  cl[0] = a[0];
  foreach (i; 1..n) cl[i] = cl[i-1]+a[i];
  cr[0] = a[$-1];
  foreach (i; 1..n) cr[i] = cr[i-1]+a[$-1-i];

  auto r = 10L^^18;
  foreach (i; 2..n-1) {
    auto d1 = divide(cl[0..i]);
    auto d2 = divide(cr[0..n-i]);
    r = min(r, max(d1[1], d2[1])-min(d1[0], d2[0]));
  }

  writeln(r);
}

auto divide(long[] c)
{
  auto t = c[$-1], cs = c.assumeSorted;
  if (t%2 == 0 && cs.contains(t/2))
    return [t/2, t/2];
  auto a = cs.lowerBound(t/2+1), b = cs.upperBound(t/2);
  if (a.empty)
    return [t-c[0], c[0]];
  auto a1 = a.back, a2 = t-a1, b2 = b.front, b1 = t-b2;
  if (a2-a1 < b2-b1)
    return [a1, a2];
  else
    return [b1, b2];
}
