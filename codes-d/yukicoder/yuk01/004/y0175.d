// URL: https://yukicoder.me/problems/no/175

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);
  int N; io.getV(N);
  io.put(2^^(L-3)*N);
}

auto io = IO!()();
import lib.io;
