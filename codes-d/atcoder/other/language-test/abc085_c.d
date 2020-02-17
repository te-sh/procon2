// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc085_c

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, Y; io.getV(N, Y);

  Y /= 1000;

  foreach (i10; 0..N+1)
    foreach (i5; 0..N+1) {
      auto i1 = N-i10-i5;
      if (i1 >= 0 && i10*10+i5*5+i1 == Y) io.put!"{exit: true}"(i10, i5, i1);
    }

  io.put(-1, -1, -1);
}

auto io = IO!()();
import lib.io;
