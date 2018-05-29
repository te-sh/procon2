// URL: http://codeforces.com/contest/980/problem/B

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
  int n, k; readV(n, k);

  auto b = new bool[][](4, n);

  if (k%2 == 0) {
    foreach (i; 0..k/2)
      b[1][i+1] = b[2][i+1] = true;
  } else if (k <= n-2) {
    foreach (i; 0..k)
      b[1][i+(n-k)/2] = true;
  } else {
    foreach (i; 0..n-2)
      b[1][i+1] = true;
    auto k2 = k-(n-2)+1;
    foreach (i; 0..k2)
      b[2][i+(n-k2)/2] = true;
    b[2][n/2] = false;
  }

  writeln("YES");
  foreach (i; 0..4) {
    foreach (j; 0..n)
      write(b[i][j] ? "#" : ".");
    writeln;
  }
}
