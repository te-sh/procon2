// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc088_b

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);

  a.sort!"a>b";

  auto s = new int[](2);
  foreach (i, ai; a) s[i%2] += ai;

  io.put(s[0]-s[1]);
}

auto io = IO!()();
import lib.io;
