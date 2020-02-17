// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc081_b

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);
  io.put(A.map!(Ai => Ai.bsf).minElement);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
