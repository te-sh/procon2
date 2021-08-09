// URL: https://yukicoder.me/problems/no/704

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n; io.getV(n);
  long[] a; io.getA(n, a);
  long[] x; io.getA(n, x);
  long[] y; io.getA(n, y);

  auto dp = new long[](n+1), st1 = new SegTree(n, inf), st2 = new SegTree(n, inf);
  foreach (i; 0..n) {
    st1[i] = dp[i]+y[i]-x[i];
    st2[i] = dp[i]+y[i]+x[i];

    auto p = x[0..i+1].assumeSorted.lowerBound(a[i]).length;
    dp[i+1] = min(st1[0..p]+a[i], st2[p..i+1]-a[i]);
  }

  io.put(dp[n]);
}

const inf = 10L^^18;
alias SegTree = SegmentTree!(min, long);
import lib.data_structure.segment_tree;

auto io = IO!()();
import lib.io;
