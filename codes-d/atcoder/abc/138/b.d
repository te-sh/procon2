// URL: https://atcoder.jp/contests/abc138/tasks/abc138_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto r = 0.0L;
  foreach (Ai; A) r += 1.0L/Ai;
  io.put(1.0L/r);
}

auto io = IO!()();
import lib.io;
