// URL: https://atcoder.jp/contests/abc174/tasks/abc174_c

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);

  if (K == 1) io.put!"{exit: true}"(1);
  if (K%2 == 0 || K%5 == 0) io.put!"{exit: true}"(-1);

  auto m = 0, s = 7;
  foreach (i; 1..K+1) {
    (m += s) %= K;
    if (m == 0) io.put!"{exit: true}"(i);
    (s *= 10) %= K;
  }
}

auto io = IO!()();
import lib.io;
