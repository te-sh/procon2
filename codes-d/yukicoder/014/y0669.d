// URL: https://yukicoder.me/problems/no/669

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] A; io.getA(N, A);
  io.putB(A.map!(ai => ai%(K+1)).reduce!"a^b" != 0, "YES", "NO");
}

auto io = IO!()();
import lib.io;
