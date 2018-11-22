// URL: https://yukicoder.me/problems/no/751

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;
import std.numeric;

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
  int n1; readV(n1);
  int[] a; readA(n1, a);
  int n2; readV(n2);
  int[] b; readA(n2, b);

  struct F { long n, p; }

  auto c = F(a[0], 1);
  foreach (ai; a[1..$]) c = F(c.n, c.p*ai);

  auto d = F(1, 1);
  foreach_reverse (bi; b) d = F(d.p*bi, d.n);

  auto e = F(c.n*d.p, c.p*d.n);
  if (e.p < 0) { e.n = -e.n; e.p = -e.p; }

  auto g = gcd(e.n.abs, e.p.abs);
  e.n /= g; e.p /= g;

  writeln(e.n, " ", e.p);
}
