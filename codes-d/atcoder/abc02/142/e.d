// URL: https://atcoder.jp/contests/abc142/tasks/abc142_e

import std;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);

  auto a = new int[](M), K = new int[](M);
  foreach (i; 0..M) {
    int ai, bi; io.getV(ai, bi);
    a[i] = ai;
    int[] ci; io.getA(bi, ci); ci[] -= 1;
    foreach (cij; ci) K[i] = K[i].bitSet(cij);
  }

  auto dp = new int[][](M+1, 1<<N);
  foreach (ref dpi; dp) dpi[] = 10^^9;
  dp[0][0] = 0;

  foreach (i; 0..M)
    foreach (j; 0..1<<N) {
      dp[i+1][j|K[i]].minU(dp[i][j] + a[i]);
      dp[i+1][j].minU(dp[i][j]);
    }

  io.putB(dp[$-1][$-1] == 10^^9, -1, dp[$-1][$-1]);
}

import lib.bitop;
import lib.minmax;

auto io = IO!()();
import lib.io;
