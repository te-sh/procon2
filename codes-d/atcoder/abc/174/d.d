// URL: https://atcoder.jp/contests/abc174/tasks/abc174_d

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  dchar[] c; io.getV(c);

  if (c.all!(ci => ci == 'R') || c.all!(ci => ci == 'W'))
    io.put!"{exit: true}"(0);

  auto i = 0, j = N-1, r = 0;
  for (;; ++r) {
    while (c[i] == 'R') ++i;
    while (c[j] == 'W') --j;
    if (i > j) io.put!"{exit: true}"(r);
    swap(c[i], c[j]);
  }
}

auto io = IO!()();
import lib.io;
