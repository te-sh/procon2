// URL: https://yukicoder.me/problems/no/741

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto dp = new mint[][](N+1, 10);
  dp[0][0] = 1;

  foreach (i; 0..N) {
    dp[i+1][0] = 1;
    foreach (j; 1..10)
      dp[i+1][j] = dp[i+1][j-1] + dp[i][j];
  }

  io.put(dp[N].sum);
}

const mod = 10^^9+7;
alias mint = ModInt!(mod, true);
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
