// URL: https://beta.atcoder.jp/contests/abc099/tasks/abc099_c

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

  auto dp1 = new int[](n+1), dp2 = new int[](n+1);
  dp1[] = n;

  foreach (i; 0..6) dp1[i] = i;

  foreach (i; 1..8) {
    dp2[] = dp1[];
    auto m = 6^^i;
    foreach (j; 0..n+1)
      foreach (k; 0..6)
        if (j >= m*k)
          dp1[j] = min(dp1[j], dp2[j-m*k]+k);
  }

  foreach (i; 1..7) {
    dp2[] = dp1[];
    auto m = 9^^i;
    foreach (j; 0..n+1)
      foreach (k; 0..9)
        if (j >= m*k)
          dp1[j] = min(dp1[j], dp2[j-m*k]+k);
  }

  writeln(dp1[n]);
}
