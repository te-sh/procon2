// URL: https://yukicoder.me/problems/no/630

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
  int n, m; readV(n, m);
  auto k = n/2;

  if (m < n-1 || m > k*(n-k)) {
    writeln("NO");
    return;
  }

  writeln("YES");
  writeA(n, iota(1, n+1));

  foreach (i; 0..k) {
    writeln(i+1, " ", k+i+1);
    if (k+i+1 < n) writeln(i+1, " ", k+i+2);
  }
  auto c = n-1;

  foreach (i; 0..k)
    foreach (j; k..n) {
      if (c == m) return;
      if (i+k == j || i+k+1 == j) continue;
      writeln(i+1, " ", j+1);
      ++c;
    }
}
