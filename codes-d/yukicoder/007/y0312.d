// URL: https://yukicoder.me/problems/no/312

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);

  auto pf = primeFactorSqrtOf(N), d = pf.divisors(N);
  io.put(d.filter!"a>2".front);
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
