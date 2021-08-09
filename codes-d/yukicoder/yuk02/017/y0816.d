// URL: https://yukicoder.me/problems/no/816

import std;

version(unittest) {} else
void main()
{
  int A, B; io.getV(A, B);

  auto pf = primeFactorSqrtOf(A+B);
  foreach (C; pf.divisors(A+B))
    if (A != C && B != C && (A+C)%B == 0 && (B+C)%A == 0)
      io.put!"{exit: true}"(C);

  io.put(-1);
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
