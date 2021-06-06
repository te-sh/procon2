// URL: https://atcoder.jp/contests/typical90/tasks/typical90_aa

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  bool[string] h;
  foreach (i; 0..N) {
    string Si; io.getV(Si);
    if (Si !in h) io.put(i+1);
    h[Si] = true;
  }
}

auto io = IO!()();
import lib.io;
