// URL: https://yukicoder.me/problems/no/733

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int T; io.getV(T);
  int N; io.getV(N);
  int[] t; io.getC(N, t);

  auto td = new int[](1<<N);
  foreach (i; 1..1<<N) {
    auto j = i.bsf;
    td[i] = td[i.bitComp(j)] + t[j];
  }

  auto dp = new int[](1<<N); dp[] = N; dp[0] = 0;
  foreach (i; 1..1<<N) {
    if (td[i] <= T) {
      dp[i] = 1;
    } else {
      foreach (j; i.bitSubset) dp[i] = min(dp[i], dp[j]+dp[i^j]);
    }
  }

  io.put(dp[$-1]);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
