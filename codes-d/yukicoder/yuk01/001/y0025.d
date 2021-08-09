// URL: https://yukicoder.me/problems/no/25

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.bigint, std.numeric;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  long M; io.getV(M);

  auto g = gcd(N, M);
  N /= g; M /= g;

  auto e2 = 0, e5 = 0;
  for (; M%2 == 0; M /= 2) ++e2;
  for (; M%5 == 0; M /= 5) ++e5;

  if (M != 1) io.put!"{exit: true}"(-1);

  auto n = BigInt(N);
  foreach (_; 0..max(0, e5-e2)) n *= 2;
  foreach (_; 0..max(0, e2-e5)) n *= 5;
  for (; n%10 == 0; n /= 10) {}
  io.put(n%10);
}

auto io = IO!()();
import lib.io;
