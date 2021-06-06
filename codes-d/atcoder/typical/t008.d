// URL: https://atcoder.jp/contests/typical90/tasks/typical90_h

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string S; io.getV(S);

  auto M = 7, T = "atcoder";
  auto dp = new mint[][](N+1, M+1);
  dp[0][0] = 1;

  foreach (i; 0..N) {
    foreach (j; 0..M)
      if (S[i] == T[j]) {
        dp[i+1][j] += dp[i][j];
        dp[i+1][j+1] += dp[i][j];
      } else {
        dp[i+1][j] += dp[i][j];
      }
    dp[i+1][M] += dp[i][M];
  }

  io.put(dp[N][M]);
}

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
