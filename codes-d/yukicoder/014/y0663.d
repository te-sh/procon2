// URL: https://yukicoder.me/problems/no/663

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] e; io.getC(N, e);

  auto calc(int a0, int a1)
  {
    auto dp = new mint[][](N, 4);
    dp[0][a1] = 1;

    foreach (i; 1..N) {
      if (e[i] == 0) {
        dp[i][0] += dp[i-1][0]+dp[i-1][2];
        dp[i][3] += dp[i-1][3];
      } else {
        dp[i][1] += dp[i-1][0]+dp[i-1][2];
        dp[i][2] += dp[i-1][1]+dp[i-1][3];
        dp[i][3] += dp[i-1][1];
      }
    }

    return dp[N-1][a0];
  }

  if (e[0] == 0)
    io.put(calc(0, 0)+calc(2, 0)+calc(3, 3));
  else
    io.put(calc(0, 1)+calc(1, 2)+calc(1, 3)+calc(2, 1)+calc(3, 2));
}

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!("%.2f")();
import lib.io;
