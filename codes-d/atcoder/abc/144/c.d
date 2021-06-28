// URL: https://atcoder.jp/contests/abc144/tasks/abc144_c

import std;

version(unittest) {} else
void main()
{
  long N; io.getV(N);

  auto d = primeFactorSqrtOf(N).divisors(N);
  io.put(d.map!(di => (di-1)+(N/di-1)).minElement);
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
