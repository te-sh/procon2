// URL: https://atcoder.jp/contests/abc086/tasks/arc089_b

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
  int n, k; readV(n, k);
  int[] x, y; string[] s; readC(n, x, y, s);

  foreach (i; 0..n) if (s[i] == "W") x[i] += k;
  auto k2 = k*2;
  x[] %= k2; y[] %= k2;

  auto c = new int[][](k2*2+1, k2*2+1);
  auto setImos(int x, int y)
  {
    c[y][x]++;
    c[y][x+k]--;
    c[y+k][x]--;
    c[y+k][x+k]++;
  }

  foreach (xi, yi; lockstep(x, y)) {
    setImos(xi+1, yi+1);
    setImos(xi+k+1, yi+k+1);
  }

  foreach (i; 0..k2*2+1)
    foreach (j; 1..k2*2+1)
      c[i][j] += c[i][j-1];
  foreach (j; 0..k2*2+1)
    foreach (i; 1..k2*2+1)
      c[i][j] += c[i-1][j];

  auto d = new int[][](k2, k2);
  foreach (i; 0..k2*2)
    foreach (j; 0..k2*2)
      d[i%k2][j%k2] += c[i][j];

  auto r = 0;
  foreach (i; 0..k2)
    foreach (j; 0..k2)
      r = max(r, d[i][j]);

  writeln(r);
}
