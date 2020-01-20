// URL: https://yukicoder.me/problems/no/4

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] W; io.getA(N, W);

  auto s = W.sum;
  if (s%2 == 1) {
    io.put("impossible");
    return;
  }

  s /= 2;

  auto dp = new bool[][](N+1, s+1);
  dp[0][0] = true;

  foreach (i, Wi; W)
    foreach (j; 0..s+1) {
      dp[i+1][j] = dp[i][j];
      if (j >= Wi) dp[i+1][j] |= dp[i][j-Wi];
    }

  io.putB(dp[N][s], "possible", "impossible");
}

auto io = IO!()();
import lib.io;
