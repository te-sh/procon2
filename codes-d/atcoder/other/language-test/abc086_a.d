// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc086_a

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int a, b; io.getV(a, b);
  io.putB(a*b%2 == 1, "Odd", "Even");
}

auto io = IO!()();
import lib.io;
