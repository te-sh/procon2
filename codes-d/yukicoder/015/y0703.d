// URL: https://yukicoder.me/problems/no/703

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  long[] a; io.getA(n, a);
  long[] x; io.getA(n, x);
  long[] y; io.getA(n, y);

  auto dp = new long[](n+1), cht = ConvexHullTrick!long();

  foreach (i; 0..n) {
    cht.add(-2*x[i], dp[i]+x[i]^^2+y[i]^^2);
    dp[i+1] = cht.query(a[i]) + a[i]^^2;
  }

  io.put(dp[n]);
}

import lib.math.convex_hull_trick;

auto io = IO!()();
import lib.io;
