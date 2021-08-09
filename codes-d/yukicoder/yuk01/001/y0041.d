// URL: https://yukicoder.me/problems/no/41

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int T; io.getV(T);
  long[] M; io.getC(T, M);

  M[] /= 111111;
  auto m = M.maxElement, c = 9;

  auto dp = new mint[][](c+1, m+1);
  dp[0][] = mint(1);

  foreach (i; 1..c+1)
    foreach (j; 0..m+1) {
      dp[i][j] = dp[i-1][j];
      if (j >= i) dp[i][j] += dp[i][j-i];
    }

  foreach (Mi; M) io.put(dp[c][Mi]);
}

const mod = 10^^9+9;
alias mint = ModInt!(mod, true);
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
