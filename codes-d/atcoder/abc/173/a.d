// URL: https://atcoder.jp/contests/abc173/tasks/abc173_a

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.putB(N%1000 == 0, 0, 1000 - N%1000);
}

auto io = IO!()();
import lib.io;
