// URL: https://yukicoder.me/problems/no/47

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.putB(N == 1, 0, (N-1).bsr+1);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
