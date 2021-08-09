// URL: https://yukicoder.me/problems/no/14

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.numeric;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);
  auto ma = a.maxElement;

  auto pf = primeFactorSqrtOf(ma);
  auto b = new int[][](ma+1);
  auto c = (ma+1).iota.map!(_ => redBlackTree!true(cast(int[])[])).array;
  foreach (ai; a) {
    auto d = pf.divisors(ai);
    if (b[ai].empty) b[ai] = d;
    foreach (di; d) c[di].insert(ai);
  }

  auto ai = a[0], r = cast(int[])[];
  foreach (i; 0..N-1) {
    r ~= ai;
    foreach (di; b[ai]) c[di].removeKey(ai);
    auto e = c.indexed(b[ai]).
      map!(ci => ci.empty ? -1 : ci.front).
      filter!"a>0".
      minElement!(ei => [lcm(ai, ei), ei]);
    ai = e;
  }

  io.put(r, ai);
}

pure T lcm(T)(T a, T b) { return a/gcd(a, b)*b; }

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
