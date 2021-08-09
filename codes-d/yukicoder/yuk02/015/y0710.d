// URL: https://yukicoder.me/problems/no/710

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A, B; io.getC(N, A, B);

  auto sa = A.sum, dp = new int[][](N+1, sa+1);
  foreach (ref dpi; dp) dpi[] = 10^^6;
  dp[0][0] = 0;

  foreach (i; 0..N)
    foreach (t; 0..sa+1) {
      dp[i+1][t] = dp[i][t]+B[i];
      if (t >= A[i])
        dp[i+1][t] = min(dp[i+1][t], dp[i][t-A[i]]);
    }

  auto r = 10^^6;
  foreach (t; 0..sa+1)
    r = min(r, max(t, dp[N][t]));

  io.put(r);
}

auto io = IO!()();
import lib.io;
