// URL: https://beta.atcoder.jp/contests/abc085/tasks/abc085_c

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int n, y; readV(n, y);

  foreach (i; 0..n+1)
    foreach (j; 0..n-i+1) {
      auto k = n-i-j;
      if (i*10000 + j*5000 + k*1000 == y) {
        writeln(i, " ", j, " ", k);
        return;
      }
    }

  writeln("-1 -1 -1");
}
