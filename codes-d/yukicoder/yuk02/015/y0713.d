// URL: https://yukicoder.me/problems/no/713

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.putB(N == 1, 0, primeFactor(N).primes.sum);
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
