// URL: https://abc092.contest.atcoder.jp/tasks/arc093_a

import std.algorithm, std.conv, std.range, std.stdio, std.string;
import std.math;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(i;0..n){t[i]=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t)v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}

void main()
{
  int n; readV(n);
  int[] a; readA(n, a);

  a = 0 ~ a ~ 0;
  auto s = 0;
  foreach (i; 0..n+1) s += (a[i+1]-a[i]).abs;

  foreach (i; 0..n)
    writeln(s-(a[i+1]-a[i]).abs-(a[i+2]-a[i+1]).abs+(a[i+2]-a[i]).abs);
}
