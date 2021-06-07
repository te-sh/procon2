// URL: https://atcoder.jp/contests/typical90/tasks/typical90_ah

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] a; io.getA(N, a);

  int i = 0, j = 0, l = 0;
  int[int] h;
  while (i < N) {
    while (h.length <= K && j < N) {
      h[a[j]]++;
      ++j;
      if (h.length <= K)
        l.maxU(j-i);
    }
    while ((h.length > K || j == N) && i < N) {
      h[a[i]]--;
      if (h[a[i]] == 0) h.remove(a[i]);
      ++i;
    }
  }
  io.put(l);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
