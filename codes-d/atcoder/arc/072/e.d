// URL: https://atcoder.jp/contests/arc072/tasks/arc072_c

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
  int n, d0; readV(n, d0);
  int[] d; readA(n, d);
  int nq; readV(nq);
  int[] q; readA(nq, q);

  auto a = new int[](n+1);
  a[0] = d0;
  foreach (i; 0..n)
    a[i+1] = d[i] < a[i]*2 ? (a[i]-d[i]).abs : a[i];

  auto b = new int[](n+1);
  b[n] = 1;
  foreach_reverse (i; 0..n)
    b[i] = b[i+1] <= d[i]/2 ? b[i+1] : b[i+1]+d[i];

  foreach (qi; q)
    writeln(a[qi-1] >= b[qi] ? "YES" : "NO");
}
