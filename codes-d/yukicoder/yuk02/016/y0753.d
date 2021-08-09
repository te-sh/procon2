// URL: https://yukicoder.me/problems/no/753

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  const n = 16;
  int[][] a; io.getM(n, n, a);

  foreach (i; 0..n)
    foreach (j; i+1..n)
      a[i][j] = a[j][i] = a[i][j] == 1 ? i : j;

  auto b = new int[][](3), c = new int[][](1<<n);
  foreach (i; 0..1<<n) {
    auto j = i.popcnt;
    if (j.popcnt == 1) {
      if (j.bsf < 3)
        b[j.bsf] ~= i;
      if (j.bsf < 4)
        foreach (k; 0..n)
          if (i.bitTest(k)) c[i] ~= k;
    }
  }

  auto dp = new long[][](1<<n, n);
  foreach (bi; b[0]) dp[bi][bi.bsf] = 1;

  foreach (k; 0..3)
    foreach (bi; b[k])
      foreach (bj; b[k])
        if (!(bi&bj))
          foreach (ci; c[bi])
            foreach (cj; c[bj])
              dp[bi|bj][a[ci][cj]] += dp[bi][ci] * dp[bj][cj];

  foreach (i; 0..1<<n)
    if (i.popcnt == 8) {
      auto j = i^((1<<16)-1);
      foreach (ci; c[i])
        foreach (cj; c[j])
          dp[i|j][a[ci][cj]] += dp[i][ci] * dp[j][cj];
    }

  foreach (i; 0..n)
    io.put(dp[$-1][i]);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
