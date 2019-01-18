// URL: https://atcoder.jp/contests/arc046/tasks/arc046_c

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n,T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);
  int[] a, b; readC(n, a, b);
  int[] c, d; readC(m, c, d);

  struct P { int a, b; bool m; }
  auto p = new P[](n+m);
  foreach (i; 0..n)
    p[i] = P(a[i], b[i], true);
  foreach (j; 0..m)
    p[n+j] = P(d[j], c[j], false);

  p.sort!"a.a == b.a ? a.m < b.m : a.a < b.a";

  auto rb = redBlackTree!(true, int)(), ans = 0;
  foreach (pi; p) {
    if (pi.m) {
      auto r = rb.upperBound(pi.b-1);
      if (!r.empty) {
        ++ans;
        rb.removeKey(r.front);
      }
    } else {
      rb.insert(pi.b);
    }
  }

  writeln(ans);
}
