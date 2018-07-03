// URL: https://yukicoder.me/problems/no/711

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

const inf = 10^^9+1;

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  foreach (i; 0..n) a[i] -= i;
  auto b = a.filter!"a>0".array;
  auto m = b.length.to!int;

  auto dp = new int[](m);
  dp[] = inf;

  foreach (i; 0..m) {
    auto bs = dp.assumeSorted.lowerBound(b[i]+1);
    dp[bs.length] = b[i];
  }

  writeln(n-dp.assumeSorted.lowerBound(inf).length.to!int);
}
