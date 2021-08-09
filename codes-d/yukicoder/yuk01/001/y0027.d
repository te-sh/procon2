// URL: https://yukicoder.me/problems/no/27

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  auto nv = 4, no = 3;
  int[] V; io.getA(nv, V);

  V.sort;
  auto mv = V[$-1];

  auto calc(int[] o)
  {
    auto dp = new int[][](no+1, mv+1);
    foreach (ref dpi; dp) dpi[] = mv;
    dp[0][0] = 0;

    foreach (i; 0..no)
      foreach (j; 0..mv+1) {
        if (dp[i][j] < 0) continue;
        foreach (k; 0..mv+1) {
          if (j-k*o[i] < 0) break;
          dp[i+1][j] = min(dp[i+1][j], dp[i][j-k*o[i]]+k);
        }
      }

    return V.map!(Vi => dp[no][Vi]).sum;
  }

  auto r = mv*4;
  foreach (A; 0..mv+1)
    foreach (B; A+1..mv+1)
      foreach (C; B+1..mv+1)
        r = min(r, calc([A, B, C]));

  io.put(r);
}

auto io = IO!()();
import lib.io;
