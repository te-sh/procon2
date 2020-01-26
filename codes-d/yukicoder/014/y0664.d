// URL: https://yukicoder.me/problems/no/664

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M, K; io.getV(N, M, K);
  int[] A; io.getC(N+1, A);

  auto dp = new long[][](N+1, M+1);
  dp[0][0] = K;
  foreach (i; 0..N)
    foreach (j; 0..M+1) {
      dp[i+1][j] = max(dp[i+1][j], dp[i][j]);
      if (j < M)
        foreach (i2; i+1..N+1)
          dp[i2][j+1] = max(dp[i2][j+1], dp[i][j]/A[i]*A[i2]+dp[i][j]%A[i]);
    }

  io.put(dp[$-1].maxElement);
}

auto io = IO!()();
import lib.io;
