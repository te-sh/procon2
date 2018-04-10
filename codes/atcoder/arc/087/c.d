// URL: https://beta.atcoder.jp/contests/abc082/tasks/arc087_a

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  int[int] h;
  foreach (ai; a) ++h[ai];

  int r = 0;
  foreach (k, v; h)
    if (v >= k) r += v-k;
    else        r += v;

  writeln(r);
}
