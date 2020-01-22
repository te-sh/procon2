// URL: https://yukicoder.me/problems/no/21

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int K; io.getV(K);
  int[] n; io.getC(N, n);
  io.put(n.maxElement - n.minElement);
}

auto io = IO!()();
import lib.io;
