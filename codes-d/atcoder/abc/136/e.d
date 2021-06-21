// URL: https://atcoder.jp/contests/abc136/tasks/abc136_e

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] A; io.getA(N, A);

  auto S = A.sum;

  auto pf = primeFactorSqrtOf(S), m = 1;
  foreach (d; pf.divisors(S)) {
    auto B = A.map!(Ai => Ai%d).array;
    B.sort;
    if (B[0..$-B.sum/d].sum <= K)
      m.maxU(d);
  }

  io.put(m);
}

import lib.minmax;
import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
