// URL: http://codeforces.com/contest/977/problem/F

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  int[int] b;
  foreach (i; 0..n) {
    if (a[i]-1 in b) b[a[i]] = b[a[i]-1]+1;
    else             b[a[i]] = 1;
  }

  auto c = -1, m = 0;
  foreach (k, v; b)
    if (v > m) {
      m = v;
      c = k;
    }

  writeln(m);

  auto d = c-m+1;
  foreach (i; 0..n)
    if (a[i] == d) {
      write(i+1, " ");
      ++d;
    }
  writeln;
}
