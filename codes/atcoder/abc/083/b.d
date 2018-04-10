// URL: https://beta.atcoder.jp/contests/abc083/tasks/abc083_b

import std.algorithm, std.conv, std.range, std.stdio, std.string;

void readV(T...)(ref T t){auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(typeof(v));r.popFront;}}
void readA(T)(size_t n,ref T t){t=new T(n);auto r=readln.splitter;foreach(ref v;t){v=r.front.to!(ElementType!T);r.popFront;}}
void readM(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=readln.splitter;foreach(ref v;t){v[i]=r.front.to!(ElementType!(typeof(v)));r.popFront;}}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=readln.splitter;foreach(ref j;v.tupleof){j=r.front.to!(typeof(j));r.popFront;}}}

void main()
{
  int n, a, b; readV(n, a, b);

  int r = 0;
  foreach (i; 1..n+1) {
    auto s = calc(i);
    if (s >= a && s <= b) r += i;
  }

  writeln(r);
}

auto calc(int n)
{
  auto r = 0;
  for (; n > 0; n /= 10) r += n%10;
  return r;
}
