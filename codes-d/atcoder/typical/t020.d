// URL: https://atcoder.jp/contests/typical90/tasks/typical90_t

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long a, b, c; io.getV(a, b, c);
  io.putB(a < c^^b, "Yes", "No");
}

auto io = IO!()();
import lib.io;
