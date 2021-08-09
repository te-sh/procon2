// URL: https://yukicoder.me/problems/no/10

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int Total; io.getV(Total);
  int[] A; io.getA(N, A);

  auto dp = new bool[][](N, Total+1); dp[N-1][Total] = true;
  foreach_reverse (i; 1..N)
    foreach (j; 0..Total+1)
      if (dp[i][j]) {
        if (j >= A[i]) dp[i-1][j-A[i]] = true;
        if (j%A[i] == 0) dp[i-1][j/A[i]] = true;
      }

  auto x = A[0], r = "";
  foreach (i; 1..N)
    if (x+A[i] <= Total && dp[i][x+A[i]]) {
      x += A[i];
      r ~= "+";
    } else {
      x *= A[i];
      r ~= "*";
    }

  io.put(r);
}

auto io = IO!()();
import lib.io;
