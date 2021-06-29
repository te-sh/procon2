// URL: https://atcoder.jp/contests/abc147/tasks/abc147_e

import std;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  int[][] A; io.getM(H, W, A);
  int[][] B; io.getM(H, W, B);

  auto C = new int[][](H, W);
  foreach (i, Ai, Bi; lockstep(A, B))
    C[i][] = Ai[] - Bi[];

  auto m = ((H-1)+(W-1)) * 80;
  auto dp = new bool[][][](H, W, m*2+1);
  dp[0][0][m-C[0][0]] = dp[0][0][m+C[0][0]] = true;

  foreach (i; 0..H)
    foreach (j; 0..W)
      foreach (k; -m..m+1) {
        auto k1 = k-C[i][j], k2 = k+C[i][j];
        if (i > 0) {
          if (-m <= k1 && k1 <= m)
            dp[i][j][k+m] |= dp[i-1][j][k1+m];
          if (-m <= k2 && k2 <= m)
            dp[i][j][k+m] |= dp[i-1][j][k2+m];
        }
        if (j > 0) {
          if (-m <= k1 && k1 <= m)
            dp[i][j][k+m] |= dp[i][j-1][k1+m];
          if (-m <= k2 && k2 <= m)
            dp[i][j][k+m] |= dp[i][j-1][k2+m];
        }
      }

  auto r = m;
  foreach (k; -m..m+1)
    if (dp[H-1][W-1][k+m])
      r.minU(abs(k));

  io.put(r);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
