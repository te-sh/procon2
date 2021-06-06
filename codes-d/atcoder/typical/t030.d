// URL: https://atcoder.jp/contests/typical90/tasks/typical90_ad

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);

  int[] f = new int[](N+1);
  foreach (i; 2..N)
    if (f[i] == 0)
      for (auto j = i; j <= N; j += i)
        f[j]++;

  io.put(f[2..$].count!(i => i >= K));
}

import lib.math.isqrt;
import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
