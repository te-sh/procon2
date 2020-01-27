// URL: https://yukicoder.me/problems/no/693

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  A.sort;

  auto r = 0;
  foreach (i; 0..N) r += (A[i]-(i+1)).abs;

  io.put(r);
}

auto io = IO!()();
import lib.io;
