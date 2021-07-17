// URL: https://atcoder.jp/contests/abc173/tasks/abc173_b

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string[] S; io.getC(N, S);

  foreach (key; ["AC", "WA", "TLE", "RE"]) {
    io.put(key, "x", S.count(key));
  }
}

auto io = IO!()();
import lib.io;
