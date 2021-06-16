// URL: https://yukicoder.me/problems/no/1513

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);

  auto dp1 = new mint[][][](N, K, K), dp2 = new mint[][][](N, K, K);
  foreach (j; 0..K)
    foreach (k; 0..K)
      if (j != k) {
        dp1[1][j][k] = 1;
        dp2[1][j][k] = j+k;
      }

  foreach (i; 1..N-1)
    foreach (j; 0..K) {
      auto b1 = new mint[](K), b2 = new mint[](K);
      foreach (l; 0..K) {
        b1[l] = dp1[i][l][j];
        b2[l] = dp2[i][l][j];
      }
      auto c1 = b1.cumulativeSum, c2 = b2.cumulativeSum;
      foreach (k; 0..K) {
        if (j > k) {
          dp1[i+1][j][k] = c1[0..j] - dp1[i][k][j];
          dp2[i+1][j][k] = c2[0..j] - dp2[i][k][j] + dp1[i+1][j][k]*k;
        } else if (j < k) {
          dp1[i+1][j][k] = c1[j+1..K] - dp1[i][k][j];
          dp2[i+1][j][k] = c2[j+1..K] - dp2[i][k][j] + dp1[i+1][j][k]*k;
        }
      }
    }

  auto ans1 = mint(0), ans2 = mint(0);
  foreach (j; 0..K)
    foreach (k; 0..K) {
      ans1 += dp1[$-1][j][k];
      ans2 += dp2[$-1][j][k];
    }

  io.put(ans1, ans2);
}

const mod = 998244353;
alias mint = ModInt!mod;

import lib.data_structure.cumulative_sum;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
