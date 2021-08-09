// URL: https://yukicoder.me/problems/no/6

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);
  int N; io.getV(N);

  auto pf = primeFactor(N);
  auto p = pf.primes.find!"a >= b"(K).array, h = p.map!hash.array;

  auto i = 0, j = 0, b = new bool[](10); b[h[i]] = true;
  auto ml = 0, mi = i;
  for (; j < h.length; ++j) {
    if (b[h[j]]) {
      while (h[i] != h[j]) b[h[i++]] = false;
      if (i < j) b[h[i++]] = false;
    }

    b[h[j]] = true;
    if (j-i >= ml) {
      mi = i;
      ml = j-i;
    }
  }
  io.put(p[mi]);
}

auto hash(int x)
{
  while (x >= 10) {
    auto y = 0;
    for (; x > 0; x /= 10) y += x%10;
    x = y;
  }
  return x;
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
