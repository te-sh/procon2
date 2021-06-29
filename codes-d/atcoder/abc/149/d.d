// URL: https://atcoder.jp/contests/abc149/tasks/abc149_d

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int R, S, P; io.getV(R, S, P);
  string T; io.getV(T);

  auto t = new int[](N);
  foreach (i; 0..N)
    switch (T[i]) {
    case 'r': t[i] = 0; break;
    case 's': t[i] = 1; break;
    case 'p': t[i] = 2; break;
    default: assert(0);
    }

  auto s = [[0, R, 0], [0, 0, S], [P, 0, 0]];
  auto r = 0;
  foreach (k; 0..K) {
    int[] u;
    for (auto i = k; i < N; i += K)
      u ~= t[i];
    auto un = u.length;

    auto dp = new int[][](un, 3);
    dp[0][0] = s[0][u[0]];
    dp[0][1] = s[1][u[0]];
    dp[0][2] = s[2][u[0]];

    foreach (i; 1..un)
      foreach (a; 0..3)
        foreach (b; 0..3)
          if (a != b)
            dp[i][a].maxU(dp[i-1][b] + s[a][u[i]]);
    r += dp[$-1].maxElement;
  }

  io.put(r);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
