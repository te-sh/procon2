// URL: https://yukicoder.me/problems/no/183

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  auto b = new bool[](1<<15), c = new bool[](1<<15);
  b[0] = true;
  foreach (Ai; A) {
    c[] = b[];
    foreach (i; 0..1<<15)
      if (b[i]) c[i^Ai] = true;
    b[] = c[];
  }

  io.put(b.count!"a");
}

auto io = IO!()();
import lib.io;
