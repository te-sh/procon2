// URL: http://codeforces.com/contest/960/problem/F

import std.algorithm, std.container, std.conv, std.math, std.range, std.typecons, std.stdio, std.string;

auto rdsp(){return readln.splitter;}
void pick(R,T)(ref R r,ref T t){t=r.front.to!T;r.popFront;}
void pickV(R,T...)(ref R r,ref T t){foreach(ref v;t)pick(r,v);}
void readV(T...)(ref T t){auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readA(T)(size_t n,ref T[]t){t=new T[](n);auto r=rdsp;foreach(ref v;t)pick(r,v);}
void readM(T)(size_t r,size_t c,ref T[][]t){t=new T[][](r);foreach(ref v;t)readA(c,v);}
void readC(T...)(size_t n,ref T t){foreach(ref v;t)v=new typeof(v)(n);foreach(i;0..n){auto r=rdsp;foreach(ref v;t)pick(r,v[i]);}}
void readS(T)(size_t n,ref T t){t=new T(n);foreach(ref v;t){auto r=rdsp;foreach(ref j;v.tupleof)pick(r,j);}}
void writeA(T)(size_t n, T t){foreach(i,v;t.enumerate){write(v);if(i<n-1)write(" ");}writeln;}

version(unittest) {} else
void main()
{
  int n, m; readV(n, m);

  struct WL { int w, l; }
  alias rbt = RedBlackTree!(WL, "a.w < b.w");

  auto dp = new rbt[](n);
  foreach (i; 0..n) dp[i] = new rbt([WL(-1, 0)]);

  auto ans = 0;
  foreach (_; 0..m) {
    int u, v, w; readV(u, v, w); --u; --v;
    auto s = dp[u].lowerBound(WL(w, 0)).back, nl = s.l+1;
    ans = max(ans, nl);

    auto t = dp[v].lowerBound(WL(w+1, 0)).back;
    if (t.l >= nl) continue;

    dp[v].insert(WL(w, nl));
    dp[v].removeKey(dp[v].upperBound(WL(w, 0)).filter!(wl => wl.l < nl));
  }

  writeln(ans);
}
