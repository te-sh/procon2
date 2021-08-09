// URL: https://yukicoder.me/problems/no/727

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const mod = 10^^9+7;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto r = 1L;

  foreach (i; 1..N+1) {
    (r *= i*2-1) %= mod;
    (r *= i) %= mod;
    (r *= i) %= mod;
  }

  io.put(r);
}

auto io = IO!()();
import lib.io;
