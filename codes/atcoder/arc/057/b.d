// URL: https://atcoder.jp/contests/arc057/tasks/arc057_b

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
  int[] a; readC(n, a);

  auto dp = new long[][](n+1, n+1), as = a.cumulativeSum;
  foreach (ref dpi; dp) dpi[] = as[0..$]+1;
  dp[0][0] = 0;

  foreach (i; 0..n)
    foreach (j; 0..i+1) {
      auto b = max(k-as[i+1..$]-dp[i][j], 0);
      auto c = i == 0 ? 1 : (dp[i][j]*a[i]/as[0..i]) + 1;
      if (c > a[i]) {
        dp[i+1][j] = min(dp[i+1][j], dp[i][j]+b);
      } else {
        dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]+max(b, c));
        dp[i+1][j] = min(dp[i+1][j], dp[i][j]+b);
      }
    }

  writeln(dp[n].count(k)-1);
}

class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  T opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  size_t opDollar() { return n; }
}
auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }
