// URL: https://yukicoder.me/problems/no/751

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n1; io.getV(n1);
  long[] A; io.getA(n1, A);
  int n2; io.getV(n2);
  long[] B; io.getA(n2, B);

  auto c = frac(A[0], 1);
  foreach (Ai; A[1..$]) c = c*frac(1, Ai);

  auto d = frac(1L, 1L);
  foreach_reverse (Bi; B) d = frac(Bi, 1)/d;

  auto e = c/d;
  io.put(e.a, e.b);
}

import lib.math.frac;

auto io = IO!()();
import lib.io;
