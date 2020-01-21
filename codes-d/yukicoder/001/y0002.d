// URL: https://yukicoder.me/problems/no/2

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto primes = Prime(N.isqrt), d = primes.div(N);
  io.putB(d.map!"a.exp".reduce!"a^b" != 0, "Alice", "Bob");
}

import lib.math.misc;

import lib.math.prime;

auto io = IO!()();
import lib.io;
