// URL: https://yukicoder.me/problems/no/191

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

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
