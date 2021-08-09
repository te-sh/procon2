// URL: https://yukicoder.me/problems/no/737

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);

  auto m = N.bsr+1;
  auto dp1 = new mint[][][](m+1, 2, m+1), dp2 = new long[][][](m+1, 2, m+1);
  dp2[0][1][0] = 1;
  foreach (i; 0..m)
    foreach (j; 0..2)
      foreach (k; 0..i+1) {
        auto md = j == 1 && !N.bitTest(m-i-1) ? 0 : 1;
        foreach (d; 0..md+1) {
          dp2[i+1][j == 1 && d == md ? 1 : 0][k+d] += dp2[i][j][k];
          dp1[i+1][j == 1 && d == md ? 1 : 0][k+d] += dp1[i][j][k]*2 + mint(dp2[i][j][k])*d;
        }
      }

  auto ans = mint(0);
  foreach (j; 0..2)
    foreach (k; 0..m+1)
      ans += dp1[$-1][j][k] * k;

  io.put(ans);
}

import lib.bitop;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
