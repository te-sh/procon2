// URL: https://atcoder.jp/contests/typical90/tasks/typical90_v

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  import std.numeric;
  long A, B, C; io.getV(A, B, C);
  auto g = gcd(gcd(A, B), C);
  io.put((A+B+C)/g-3);
}

auto io = IO!()();
import lib.io;
