// URL: https://yukicoder.me/problems/no/302

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.mathspecial;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  long L, R; io.getV(L, R);

  if (L > N*6) io.put!"{exit: true}"(0);

  if (N < 5000) {
    auto dp = [1.0];

    foreach (i; 0..N) {
      auto dp2 = new double[(i+1)*6+2]; dp2.fill(0);
      foreach (j; 0..i*6+1) {
        dp2[j+1] += dp[j]/6;
        dp2[j+7] -= dp[j]/6;
      }
      foreach (j; 1..(i+1)*6+1)
        dp2[j] += dp2[j-1];
      dp = dp2;
    }

    io.put(dp[L..min(N*6, R)+1].sum);
  } else {
    auto mu = 7.0/2*N, sigma = sqrt(35.0/12*N);
    io.put((erfc(-(R+0.5-mu)/(sqrt(2.0)*sigma))-erfc(-(L-0.5-mu)/(sqrt(2.0)*sigma)))/2);
  }
}

auto io = IO!()();
import lib.io;
