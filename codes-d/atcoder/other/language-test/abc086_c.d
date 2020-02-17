// URL: https://atcoder.jp/contests/language-test-202001/tasks/arc089_a

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] t, x, y; io.getC(N, t, x, y);

  t = [0]~t; x = [0]~x; y = [0]~y;

  foreach (i; 1..N+1)
    if (t[i]%2 != (x[i]+y[i])%2 || t[i]-t[i-1] < abs(x[i]-x[i-1])+abs(y[i]-y[i-1]))
      io.put!"{exit: true}"("No");

  io.put("Yes");
}

auto io = IO!()();
import lib.io;
