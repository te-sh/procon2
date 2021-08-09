// URL: https://yukicoder.me/problems/no/26

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto c = new bool[](4);
  c[N] = true;

  int M; io.getV(M);
  foreach (_; 0..M) {
    int P, Q; io.getV(P, Q);
    swap(c[P], c[Q]);
  }

  io.put(c.countUntil(true));
}

auto io = IO!()();
import lib.io;
