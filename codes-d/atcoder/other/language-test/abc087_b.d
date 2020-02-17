// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc087_b

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int A; io.getV(A);
  int B; io.getV(B);
  int C; io.getV(C);
  int X; io.getV(X);

  auto r = 0;
  foreach (a; 0..A+1)
    foreach (b; 0..B+1)
      foreach (c; 0..C+1)
        if (a*500+b*100+c*50 == X) ++r;

  io.put(r);
}

auto io = IO!()();
import lib.io;
