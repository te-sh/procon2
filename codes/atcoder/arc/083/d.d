// URL: https://beta.atcoder.jp/contests/abc074/tasks/arc083_b

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
  int[][] a; readM(n, n, a);

  auto b = new bool[][](n, n);
  foreach (i; 0..n) b[i][i] = true;

  auto r = 0L;
  foreach (i; 0..n-1)
    foreach (j; i+1..n)
      r += a[i][j];

  foreach (i; 0..n)
    foreach (j; 0..n)
      foreach (k; 0..n) {
        if (a[i][j] > a[i][k]+a[k][j]) {
          writeln(-1);
          return;
        } else if (a[i][j] == a[i][k]+a[k][j] && i != k && j != k && !b[i][j]) {
          r -= a[i][j];
          b[i][j] = b[j][i] = true;
        }
      }

  writeln(r);
}
