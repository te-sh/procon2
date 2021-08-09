// URL: https://yukicoder.me/problems/no/1501

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  long[] A; io.getA(N, A);

  if (K == 1) {
    if (N == 1) io.put!"{exit: true}"("1/1");
    else io.put!"{exit: true}"(0);
  }

  auto a = new Frac!long[](N), b = new Frac!long[](N);
  foreach (i; 1..N-1) {
    a[i] = frac(A[i-1], A[i-1]+A[i+1]);
    b[i] = frac(A[i+1], A[i-1]+A[i+1]);
  }

  auto c = new Frac!long[](N); c[0] = frac(0L, 1L);
  foreach (i; 1..N-1)
    c[i] = b[i] / (frac(1L, 1L) - a[i] * c[i-1]);

  auto r = frac(1L, 1L);
  foreach (i; K-1..N-1) r *= c[i];

  io.put(r.a.to!string ~ "/" ~ r.b.to!string);
}

import lib.math.frac;

auto io = IO!()();
import lib.io;
