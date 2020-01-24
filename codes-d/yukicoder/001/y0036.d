// URL: https://yukicoder.me/problems/no/36

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);

  auto primes = Prime(cast(int)N.isqrt);
  io.putB(primes.div(N).map!"a.exp".sum >= 3, "YES", "NO");
}

import lib.math.misc;

import lib.math.prime;

auto io = IO!()();
import lib.io;
