// URL: https://yukicoder.me/problems/no/7

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto pf = primeFactor(N), b = new bool[](N+1);
  b[0] = b[1] = true;
  auto bs = pf.primes.assumeSorted;
  foreach (i; 2..N+1) b[i] = !bs.lowerBound(i+1).map!(p => b[i-p]).all;

  io.putB(b[N], "Win", "Lose");
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
