// URL: https://yukicoder.me/problems/no/699

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.bitmanip;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto r = 0, mask = (1<<N)-1;
  foreach (i; 0..1<<N) {
    if (i.popcnt != N/2) continue;

    auto b = i.bitsSet.array, c = (~i&mask).bitsSet.array;
    foreach (d; c.permutations) {
      auto s = 0;
      foreach (j; 0..N/2) s ^= A[b[j]]+A[d[j]];
      r = max(r, s);
    }
  }

  io.put(r);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
