// URL: https://yukicoder.me/problems/no/44

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto dp = new long[](N+1);
  dp[0..2] = [1, 1];
  foreach (i; 2..N+1) dp[i] = dp[i-1]+dp[i-2];

  io.put(dp[N]);
}

auto io = IO!()();
import lib.io;
