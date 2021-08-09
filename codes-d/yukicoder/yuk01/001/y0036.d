// URL: https://yukicoder.me/problems/no/36

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  auto pf = primeFactorSqrtOf(N);
  io.putB(pf.div(N).map!"a.exp".sum >= 3, "YES", "NO");
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
