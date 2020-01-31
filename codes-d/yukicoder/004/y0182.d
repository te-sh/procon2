// URL: https://yukicoder.me/problems/no/182

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  int[int] c;
  foreach (Ai; A) ++c[Ai];

  io.put(c.byValue.count!"a==1");
}

auto io = IO!()();
import lib.io;
