// URL: https://atcoder.jp/contests/abc145/tasks/abc145_e

import std;

version(unittest) {} else
void main()
{
  int N, T; io.getV(N, T);
  struct F { int A, B; }
  F[] f; io.getS!("A", "B")(N, f);
  f.sort!"a.A<b.A";

  auto m = T+f[$-1].A, dp = new int[][](N+1, m);
  foreach (i; 0..N)
    foreach (j; 0..m) {
      dp[i+1][j].maxU(dp[i][j]);
      if (j-f[i].A >= 0 && j-f[i].A < T)
        dp[i+1][j].maxU(dp[i][j-f[i].A]+f[i].B);
    }

  io.put(dp[$-1].maxElement);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
