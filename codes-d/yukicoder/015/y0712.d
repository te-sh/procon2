// URL: https://yukicoder.me/problems/no/712

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  string[] A; io.getC(N, A);
  io.put(N*M - A.map!(ai => ai.count('R')).sum);
}

auto io = IO!()();
import lib.io;
