// URL: https://beta.atcoder.jp/contests/abc089/tasks/abc089_c

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
  string[] s; readC(n, s);

  auto t = ['M', 'A', 'R', 'C', 'H'];

  auto h = new long[](5);
  foreach (si; s) {
    auto i = t.countUntil(si[0]);
    if (i >= 0) h[i]++;
  }

  auto calc(int a, int b, int c)
  {
    return h[a].to!long * h[b] * h[c];
  }

  auto r =
    calc(0, 1, 2) + calc(0, 1, 3) + calc(0, 1, 4) + calc(0, 2, 3) + calc(0, 2, 4) +
    calc(0, 3, 4) + calc(1, 2, 3) + calc(1, 2, 4) + calc(1, 3, 4) + calc(2, 3, 4);
  writeln(r);
}
