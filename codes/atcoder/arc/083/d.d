// URL: https://beta.atcoder.jp/contests/abc074/tasks/arc083_b

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

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
