// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc085_b

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] d; io.getC(N, d);

  d.sort;
  io.put(d.uniq.walkLength);
}

auto io = IO!()();
import lib.io;
