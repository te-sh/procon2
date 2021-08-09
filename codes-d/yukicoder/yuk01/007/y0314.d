// URL: https://yukicoder.me/problems/no/314

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto dp = new mint[][](N+1, 3);
  dp[1][1] = 1;

  foreach (i; 2..N+1) {
    dp[i][0] = dp[i-1][1]+dp[i-1][2];
    dp[i][1] = dp[i-1][0];
    dp[i][2] = dp[i-1][1];
  }

  io.put(dp[N].sum);
}

const mod = 10^^9+7;
alias mint = ModInt!(mod, true);
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
