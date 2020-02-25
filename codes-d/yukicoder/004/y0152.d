// URL: https://yukicoder.me/problems/no/152

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;
import std.numeric;

version(unittest) {} else
void main()
{
  int L; io.getV(L);

  auto l = L/4, r = 0;
  foreach (m; 2..l.isqrt)
    for (auto n = m%2+1; n < m; n += 2) {
      if (gcd(m, n) != 1) continue;
      if (m*(m+n)*2 > l) break;
      ++r;
    }

  io.put(r%mod);
}

const mod = 1000003;

import lib.math.isqrt;

auto io = IO!()();
import lib.io;
