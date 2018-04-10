// URL: https://beta.atcoder.jp/contests/abc087/tasks/abc087_b

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int a; readV(a);
  int b; readV(b);
  int c; readV(c);
  int x; readV(x);

  int r = 0;
  foreach (i; 0..a+1)
    foreach (j; 0..b+1)
      foreach (k; 0..c+1)
        if (i*500+j*100+k*50 == x) ++r;

  writeln(r);
}
