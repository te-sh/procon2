// URL: https://yukicoder.me/problems/no/2

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  auto pf = primeFactorSqrtOf(N), d = pf.div(N);
  io.putB(d.map!"a.exp".reduce!"a^b" != 0, "Alice", "Bob");
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
