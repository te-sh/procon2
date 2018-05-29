// URL: http://codeforces.com/contest/965/problem/C

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  long n, k, m, d; readV(n, k, m, d);

  auto calc(long di, long x)
  {
    return (di-1)*k+1 <= n/x;
  }

  auto binarySearch(long di)
  {
    auto mi = 1L, ma = m;
    while (ma-mi > 1) {
      auto mc = (ma+mi)/2;
      if (calc(di, mc)) mi = mc;
      else              ma = mc;
    }
    if      (calc(di, ma)) return ma;
    else if (calc(di, mi)) return mi;
    else                   return mi-1;
  }

  auto ans = 0L;
  foreach (di; 1..min(d, (n-1)/k+1)+1) {
    auto x = binarySearch(di);
    ans = max(ans, di*x);
  }

  writeln(ans);
}
