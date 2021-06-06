// URL: https://atcoder.jp/contests/typical90/tasks/typical90_g

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  A ~= [-10^^9, 2 * 10^^9];
  auto a = A.sort();

  int Q; io.getV(Q);
  foreach (_; 0..Q) {
    int B; io.getV(B);
    auto r = a.lowerBound(B).length;
    io.put(min(abs(B-a[r-1]), abs(B-a[r])));
  }
}

auto io = IO!()();
import lib.io;
