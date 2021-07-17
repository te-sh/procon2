// URL: https://atcoder.jp/contests/abc142/tasks/abc142_d

import std;

version(unittest) {} else
void main()
{
  long A, B; io.getV(A, B);
  auto g = gcd(A, B);

  auto pf = primeFactorSqrtOf(g);
  auto f = pf.div(g);

  io.put(f.length+1);
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
