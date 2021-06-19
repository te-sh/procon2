// URL: https://atcoder.jp/contests/abc175/tasks/abc175_e

import std;

version(unittest) {} else
void main()
{
  int R, C, K; io.getV(R, C, K);

  auto V = new long[][](R, C);
  foreach (_; 0..K) {
    int ri, ci, vi; io.getV(ri, ci, vi); --ri; --ci;
    V[ri][ci] = vi;
  }

  auto dp = new long[][][](R, C, 4);
  dp[0][0][1] = V[0][0];
  foreach (i; 0..R)
    foreach (j; 0..C) {
      if (i > 0)
        foreach (k; 0..4)
          dp[i][j][0].maxU(dp[i-1][j][k]);
      if (j > 0)
        dp[i][j][0].maxU(dp[i][j-1][0]);

      if (i > 0)
        foreach (k; 0..4)
          dp[i][j][1].maxU(dp[i-1][j][k] + V[i][j]);
      if (j > 0)
        dp[i][j][1].maxU(dp[i][j-1][0]+V[i][j]).maxU(dp[i][j-1][1]);

      if (j > 0)
        dp[i][j][2].maxU(dp[i][j-1][1]+V[i][j]).maxU(dp[i][j-1][2]);

      if (j > 0)
        dp[i][j][3].maxU(dp[i][j-1][2]+V[i][j]).maxU(dp[i][j-1][3]);
    }
  io.put(dp[R-1][C-1].maxElement);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
