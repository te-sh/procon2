// URL: https://atcoder.jp/contests/abc116/tasks/abc116_d

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
  int n, k; readV(n, k);
  struct S { int t, d; }
  S[] s; readS(n, s);

  s.sort!"a.d>b.d";

  auto c = new int[](100001), p = 0L, q = 0L;
  foreach (i; 0..k) {
    if (c[s[i].t]++ == 0) ++q;
    p += s[i].d;
  }

  auto r = p+q*q, i = k-1, j = k;

  auto findOut(int i)
  {
    for (; i >= 0; --i)
      if (c[s[i].t] >= 2)
        return i;
    return -1;
  }

  auto findIn(int j)
  {
    for (; j < n; ++j)
      if (c[s[j].t] == 0)
        return j;
    return -1;
  }

  for (;;) {
    i = findOut(i);
    if (i == -1) break;
    --c[s[i].t];
    p -= s[i].d;
    --i;

    j = findIn(j);
    if (j == -1) break;
    ++c[s[j].t];
    p += s[j].d;
    ++j;

    ++q;
    r = max(r, p+q*q);
  }

  writeln(r);
}
