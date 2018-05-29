// URL: https://beta.atcoder.jp/contests/arc079/tasks/arc079_c

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
  long[] a; readA(n, a);

  a.sort!"a>b";
  auto ans = 0L;

  while (a[$-1] < n) {
    if (a[0] < n) {
      writeln(ans);
      return;
    }
    a[] += 1;
    a[0] -= n+1;
    ++ans;
    a.sort!"a>b";
  }

  foreach (i; 1..n) {
    auto c = (a[0]-a[i])/(n+1);
    ans += c*i;
    a[0..i][] -= c*(n-i+1);
    a[i..$][] += c*i;
  }

  auto d = max(0, a[0]-n*2);
  ans += d*n;
  a[] -= d;

  while (a[0] >= n) {
    a[] += 1;
    a[0] -= n+1;
    ++ans;
    a.sort!"a>b";
  }

  writeln(ans);
}
