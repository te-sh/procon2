// URL: https://beta.atcoder.jp/contests/arc077/tasks/arc077_c

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
  int[] a; readA(n, a);

  auto p = new int[][](m+1);
  foreach (int i, ai; a) p[ai] ~= i;

  auto k = 0, c = 0L;
  foreach (i; 0..n-1)
    if (a[i] > a[i+1]) {
      ++k;
      c += a[i+1];
    } else {
      c += a[i+1]-a[i];
    }

  auto ans = c;
  foreach (i; 1..m) {
    c -= k;

    foreach (j; p[i]) {
      if (j > 0) {
        --k;
        c += a[j-1] > a[j] ? a[j]+m-a[j-1] : a[j]-a[j-1];
      }
      if (j < n-1)
        ++k;
    }

    ans = min(ans, c);
  }

  writeln(ans);
}
