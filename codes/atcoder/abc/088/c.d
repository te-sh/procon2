// URL: https://beta.atcoder.jp/contests/abc088/tasks/abc088_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!T;r.popFront;}}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref ti;t)readA(c,ti);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

version(unittest) {} else
void main()
{
  int[][] c; readM(3, 3, c);
  writeln(c[1][1] == c[1][0]-c[0][0]+c[0][1] &&
          c[1][2] == c[1][0]-c[0][0]+c[0][2] &&
          c[2][1] == c[2][0]-c[0][0]+c[0][1] &&
          c[2][2] == c[2][0]-c[0][0]+c[0][2] ? "Yes" : "No");
}
