// URL: https://yukicoder.me/problems/no/752

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
  long p; int q; readV(p, q);

  auto maxM = min(p, 10L^^4), maxK = p/(maxM+1);

  auto b = new long[](maxK+1);
  foreach (k; 1..maxK+1)
    b[k] = b[k-1] + p%k;

  auto c = new long[](maxM+2); c[$-1] = b[$-1];
  foreach_reverse (m; 1..maxM+1) {
    auto u = p/(m+1)+1, v = p/m;
    c[m] = c[m+1] + p*(v-u+1) - m*(v*(v+1)-u*(u-1))/2;
  }

  auto calc(long x)
  {
    if (x <= maxK) {
      return b[x];
    } else {
      auto m = p/x, u = p/(m+1)+1;
      return c[m+1] + p*(x-u+1) - m*(x*(x+1)-u*(u-1))/2;
    }
  }

  foreach (_; 0..q) {
    long l, r; readV(l, r);
    writeln(calc(r) - calc(l-1));
  }
}
