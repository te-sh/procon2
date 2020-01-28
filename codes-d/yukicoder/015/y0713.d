// URL: https://yukicoder.me/problems/no/713

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.putB(N == 1, 0, Prime(N).array.sum);
}

import lib.math.prime;

auto io = IO!()();
import lib.io;
