// URL: https://atcoder.jp/contests/abc118/tasks/abc118_d

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
  int[] a; readA(m, a);
  auto b = [0, 2, 5, 5, 4, 5, 6, 3, 7, 6];
  auto as = a.map!(to!string).array;

  auto dp = new string[](n+1); dp[1..$][]= "x";
  foreach (i; 1..n+1)
    foreach (ai, asi; lockstep(a, as))
      if (i >= b[ai] && dp[i-b[ai]] != "x")
        dp[i] = maxS(dp[i], asi ~ dp[i-b[ai]]);

  writeln(dp[n]);
}

auto maxS(string s, string t)
{
  if (s == "x") swap(s, t);

  if (s == "x") return "x";
  if (t == "x") return s;
  if (s.length > t.length) return s;
  if (s.length < t.length) return t;

  return max(s, t);
}
