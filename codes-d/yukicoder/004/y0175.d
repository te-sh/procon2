// URL: https://yukicoder.me/problems/no/175

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);
  int N; io.getV(N);
  io.put(2^^(L-3)*N);
}

auto io = IO!()();
import lib.io;
