// URL: https://atcoder.jp/contests/aising2020/tasks/aising2020_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto n = isqrt(N);
  auto c = new int[](N+1);

  foreach (x; 1..n+1)
    foreach (y; 1..n+1)
      foreach (z; 1..n+1) {
        auto u = x*x+y*y+z*z+x*y+y*z+z*x;
        if (u <= N) c[u]++;
      }

  foreach (ci; c[1..$]) io.put(ci);
}

import lib.math.isqrt;

auto io = IO!()();
import lib.io;
