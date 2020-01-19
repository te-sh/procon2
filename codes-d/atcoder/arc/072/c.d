// URL: https://atcoder.jp/contests/abc059/tasks/arc072_a

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
  int n; readV(n);
  int[] a; readA(n, a);

  auto ans1 = 0L, s1 = 0L;
  foreach (i; 0..n) {
    s1 += a[i];
    if (i%2 == 0) {
      if (s1 <= 0) {
        ans1 += -s1 + 1;
        s1 = 1;
      }
    } else {
      if (s1 >= 0) {
        ans1 += s1 + 1;
        s1 = -1;
      }
    }
  }

  auto ans2 = 0L, s2 = 0L;
  foreach (i; 0..n) {
    s2 += a[i];
    if (i%2 == 1) {
      if (s2 <= 0) {
        ans2 += -s2 + 1;
        s2 = 1;
      }
    } else {
      if (s2 >= 0) {
        ans2 += s2 + 1;
        s2 = -1;
      }
    }
  }

  writeln(min(ans1, ans2));
}
