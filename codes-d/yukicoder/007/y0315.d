// URL: https://yukicoder.me/problems/no/315

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  string A, B; int P; io.getV(A, B, P);

  auto calc(int[] n)
  {
    auto nl = cast(int)n.length;

    if (nl <= 5) {
      auto r = mint(0);
      foreach (i; 1..d2i(n)+1)
        if ((i%3 == 0 || include3(i)) && i%P != 0)
          ++r;
      return r;
    }

    auto dp = new mint[][][][](nl-4, 2, 3, 2);
    dp[0][1][0][0] = 1;
    foreach (i; 0..nl-5)
      foreach (j; 0..2) {
        auto d = j ? n[i] : 9;
        foreach (k; 0..3)
          foreach (l; 0..2)
            foreach (m; 0..d+1)
              dp[i+1][j && m==d][(k+m)%3][l || m==3] += dp[i][j][k][l];
      }

    auto dp2 = new mint[][][](3, 2, 2);
    foreach (j; 0..2) {
      auto d = j ? d2i(n.tail(5)) : 99999;
      foreach (k; 0..3)
        foreach (l; 0..2)
          foreach (m; 0..d+1)
            dp2[(k+m)%3][l || include3(m)][m%P == 0] += dp[nl-5][j][k][l];
    }

    return dp2[0][0][0] + dp2[0][1][0] + dp2[1][1][0] + dp2[2][1][0];
  }

  auto a = s2d(A), b = s2d(B), r = calc(b)-calc(a);
  if ((a.sum%3 == 0 || a.canFind(3)) && d2i(a.tail(5))%P != 0) ++r;
  io.put(r);
}

auto include3(int n)
{
  for (; n > 0; n /= 10)
    if (n%10 == 3) return true;
  return false;
}

auto s2d(string s)
{
  return s.map!(c => cast(int)(c-'0')).array;
}

auto d2i(int[] a)
{
  auto r = 0;
  foreach (ai; a) r = r*10+ai;
  return r;
}

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int2;

auto io = IO!()();
import lib.io;
