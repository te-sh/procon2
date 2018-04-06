// URL: http://codeforces.com/contest/957/problem/C

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int n, u; readV(n, u);
  int[] e; readA(n, e);
  auto es = e.assumeSorted;

  auto y = -1.0L;
  foreach (i; 0..n-2) {
    if (e[i+2]-e[i] > u) continue;
    auto ei = e[i], ej = e[i+1];
    auto ek = es.lowerBound(ei+u+1).back;
    y = max(y, (ek-ej).to!real/(ek-ei));
  }

  if (y < 0)
    writeln(-1);
  else
    writefln("%.10f", y);
}
