// URL: https://beta.atcoder.jp/contests/abc086/tasks/arc089_a

import std.algorithm, std.conv, std.range, std.stdio, std.string;
import std.math;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int n; readV(n);
  int[] t, x, y; readM(n, t, x, y);

  if ((x[0]+y[0])%2 != t[0]%2 || x[0]+y[0] > t[0]) {
    writeln("No");
    return;
  }

  foreach (i; 1..n)
    if ((x[i]+y[i])%2 != t[i]%2 || (x[i]-x[i-1]).abs+(y[i]-y[i-1]).abs > t[i]-t[i-1]) {
      writeln("No");
      return;
    }

  writeln("Yes");
}
