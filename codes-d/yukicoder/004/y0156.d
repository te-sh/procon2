// URL: https://yukicoder.me/problems/no/156

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  int[] C; io.getA(N, C);

  C.sort;

  auto r = 0;
  foreach (i, Ci; C) {
    r += Ci;
    if (r > M) { io.put(i); return; }
  }

  io.put(N);
}

auto io = IO!()();
import lib.io;
