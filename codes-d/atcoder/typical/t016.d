// URL: https://atcoder.jp/contests/typical90/tasks/typical90_p

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  long A, B, C; io.getV(A, B, C);

  auto r = 10000L;
  foreach (i; 0..10000L)
    foreach (j; 0..10000L-i) {
      auto m = N - A*i - B*j;
      if (m >= 0 && m%C == 0) r.minU(i+j+m/C);
    }

  io.put(r);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
