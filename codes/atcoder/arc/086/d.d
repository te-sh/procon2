// URL: https://beta.atcoder.jp/contests/abc081/tasks/arc086_b

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  auto mi = a.reduce!min, ma = a.reduce!max;
  auto b = mi.abs > ma.abs ? mi : ma, i = a.countUntil(b);

  if (b == 0) {
    writeln(0);
  } else if (b > 0) {
    writeln(n*2-2);
    writeln(i+1, " ", 2);
    writeln(i+1, " ", 2);
    foreach (j; 2..n) {
      writeln(j, " ", j+1);
      writeln(j, " ", j+1);
    }
  } else {
    writeln(n*2-2);
    writeln(i+1, " ", n-1);
    writeln(i+1, " ", n-1);
    foreach_reverse (j; 0..n-2) {
      writeln(j+2, " ", j+1);
      writeln(j+2, " ", j+1);
    }
  }
}

