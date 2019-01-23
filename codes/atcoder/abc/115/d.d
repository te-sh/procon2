// URL: https://atcoder.jp/contests/abc115/tasks/abc115_d

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
  int n; long x; readV(n, x);

  auto h = new long[](n), p = new long[](n);
  h[0] = 1; p[0] = 1;
  foreach (i; 0..n) {
    h[i+1] = h[i]*2+3;
    p[i+1] = p[i]*2+1;
  }

  long pat(int i, long x)
  {
    if (i == 0) return 1;

    if (x == 1) return 0;
    else if (x <= h[i-1]+1) return pat(i-1, x-1);
    else if (x == h[i-1]+2) return p[i-1]+1;
    else if (x <= h[i-1]*2+2) return p[i-1]+1+pat(i-1, x-h[i-1]-2);
    else return p[i-1]*2+1;
  }

  writeln(pat(n, x));
}
