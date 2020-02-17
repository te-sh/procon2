// URL: https://atcoder.jp/contests/language-test-202001/tasks/abc083_b

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, A, B; io.getV(N, A, B);

  auto r = 0;
  foreach (x; 1..N+1) {
    auto s = sumFigures(x);
    if (A <= s && s <= B) r += x;
  }

  io.put(r);
}

auto sumFigures(int x)
{
  int r = 0;
  for (; x > 0; x /= 10) r += x%10;
  return r;
}

auto io = IO!()();
import lib.io;
