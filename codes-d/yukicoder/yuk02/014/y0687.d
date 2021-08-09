// URL: https://yukicoder.me/problems/no/687

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  foreach (a1; 1..11)
    foreach (a2; 1..11)
      if (a1+a2 == N) io.put!"{exit: true}"(a1, a2);
}

auto io = IO!()();
import lib.io;
