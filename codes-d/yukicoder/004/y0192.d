// URL: https://yukicoder.me/problems/no/192

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.putB(N%2 == 0, N, N+1);
}

auto io = IO!()();
import lib.io;
