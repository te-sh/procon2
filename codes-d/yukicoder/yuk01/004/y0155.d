// URL: https://yukicoder.me/problems/no/155

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, L; io.getV(N, L);
  string[] st; io.getA(N, st);

  L *= 60;
  auto S = st.map!(sti => sti[0..2].to!int*60+sti[3..5].to!int).array;

  if (S.sum < L) io.put!"{exit: true}"(N);

  auto dp1 = new long[][][](N+1, N+1, L); dp1[0][0][0] = 1;
  foreach (i, Si; S)
    foreach (j; 0..N+1)
      foreach (k; 0..L) {
        dp1[i+1][j][k] = dp1[i][j][k];
        if (j >= 1 && k >= Si)
          dp1[i+1][j][k] += dp1[i][j-1][k-Si];
      }

  auto fact = Fact!(double, false)(N+1);

  auto r = 0.0, dp2 = new long[][](N+1, L);
  foreach (i, Si; S) {
    foreach (j; 0..N+1)
      foreach (k; 0..L) {
        dp2[j][k] = dp1[N][j][k];
        if (j >= 1 && k >= Si)
          dp2[j][k] -= dp2[j-1][k-Si];
      }

    foreach (j; 0..N)
      foreach (k; max(0, L-Si)..L)
        r += dp2[j][k]*fact[j+1]*fact[N-1-j];
  }

  io.put(r/fact[N]);
}

import lib.math.fact;

auto io = IO!()();
import lib.io;
