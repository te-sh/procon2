// URL: https://atcoder.jp/contests/abc174/tasks/abc174_b

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; long D; io.getV(N, D);
  long[] X, Y; io.getC(N, X, Y);

  auto D2 = D*D, c = 0;
  foreach (Xi, Yi; lockstep(X, Y))
    if (Xi*Xi + Yi*Yi <= D2) ++c;

  io.put(c);
}

auto io = IO!()();
import lib.io;
