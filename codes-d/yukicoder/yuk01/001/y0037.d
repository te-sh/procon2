// URL: https://yukicoder.me/problems/no/37

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int T; io.getV(T);
  int N; io.getV(N);
  int[] c; io.getA(N, c);
  int[] v; io.getA(N, v);

  struct A { int c, v; }

  auto vList(int v)
  {
    int[] r;
    for (; v > 0; v /= 2) r ~= v;
    return r;
  }

  auto aList(int c, int v)
  {
    return vList(v).map!(vi => A(c, vi));
  }

  auto a = N.iota.map!(i => aList(c[i], v[i])).joiner.array;

  auto dp = new int[][](a.length+1, T+1);
  foreach (ref dpi; dp) dpi[] = -1; dp[0][0] = 0;

  foreach (i, ai; a)
    foreach (j; 0..T+1) {
      dp[i+1][j] = dp[i][j];
      if (j >= ai.c && dp[i][j-ai.c] >= 0)
        dp[i+1][j] = max(dp[i+1][j], dp[i][j-ai.c] + ai.v);
    }

  io.put(dp[$-1].maxElement);
}

auto io = IO!()();
import lib.io;
