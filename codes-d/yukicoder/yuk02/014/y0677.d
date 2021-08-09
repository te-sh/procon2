// URL: https://yukicoder.me/problems/no/677

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  long[] f;
  foreach (i; 0..N+1)
    foreach (j; 0..N+1)
      f ~= 2L^^i * 5L^^j;

  f.sort;
  foreach (fi; f) io.put(fi);
}

auto io = IO!()();
import lib.io;
