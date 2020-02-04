// URL: https://yukicoder.me/problems/no/189

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string M, D; io.getV(M, D);

  auto m = M.map!(c => cast(int)c-'0').array, d = D.map!(c => cast(int)c-'0').array;

  auto dpm = calc(m), dpd = calc(d), r = mint(0);
  foreach (i; 1..min(m.length, d.length)*9+1) r += dpm[i]*dpd[i];
  io.put(r);
}

auto calc(int[] a)
{
  auto n = a.length, dp = new mint[][][](n+1, n*9+1, 2);
  dp[0][0][0] = 1;

  foreach (i, ai; a)
    foreach (j; 0..n*9+1)
      foreach (k; 0..2) {
        auto md = k==0 ? ai : 9;
        foreach (d; 0..md+1) {
          if (j+d <= n*9)
            dp[i+1][j+d][k == 0 && d == ai ? 0 : 1] += dp[i][j][k];
        }
      }

  return dp[$-1].map!(dpi => dpi.sum).array;
}

const mod = 10^^9+9;
alias mint = ModInt!(mod, true);
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
