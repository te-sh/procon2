// URL: https://beta.atcoder.jp/contests/abc088/tasks/abc088_c

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  auto c = new int[][](3, 3); foreach (i; 0..3) readA(3, c[i]);
  writeln(c[1][1] == c[1][0]-c[0][0]+c[0][1] &&
          c[1][2] == c[1][0]-c[0][0]+c[0][2] &&
          c[2][1] == c[2][0]-c[0][0]+c[0][1] &&
          c[2][2] == c[2][0]-c[0][0]+c[0][2] ? "Yes" : "No");
}
