// URL: https://yukicoder.me/problems/no/191

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] C; io.getA(N, C);

  auto s = C.sum;
  io.put(C.count!(Ci => Ci*10 <= s)*30);
}

auto io = IO!()();
import lib.io;
