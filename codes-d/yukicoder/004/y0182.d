// URL: https://yukicoder.me/problems/no/182

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

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
