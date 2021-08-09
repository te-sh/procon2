// URL: https://yukicoder.me/problems/no/698

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto dp = new int[](1<<N);
  foreach (i; 1..1<<N)
    if (i.popcnt % 2 == 0)
      foreach (j; 0..N)
        if (i.bitTest(j))
          foreach (k; j+1..N)
            if (i.bitTest(k))
              dp[i] = max(dp[i], dp[i.bitReset(j).bitReset(k)] + (A[j]^A[k]));

  io.put(dp[$-1]);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
