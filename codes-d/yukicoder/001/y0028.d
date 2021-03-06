// URL: https://yukicoder.me/problems/no/28

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int Q; io.getV(Q);

  auto pf = primeFactor(6);
  alias Factor = pf.Factor;

  auto expo(int x, int p)
  {
    auto e = 0;
    for (; x%p == 0; x /= p) ++e;
    return e;
  }
  
  auto calc()
  {
    int seed, N, K, B; io.getV(seed, N, K, B);

    auto bd = pf.div(B);

    auto xl = new long[](N+1); xl[0] = seed;
    foreach (i; 1..N+1)
      xl[i] = 1 + (xl[i-1]^^2 + xl[i-1]*12345)%100000009;
    auto X = xl.map!"cast(int)a".array;

    auto k = 10^^9;
    foreach (i; 0..bd.length) {
      auto xd = new int[](N+1);
      foreach (j; 0..N+1) xd[j] = expo(X[j], bd[i].prime);
      xd.sort;
      k = min(k, (xd[0..K].sum)/bd[i].exp);
    }

    io.put(k);
  }

  foreach (_; 0..Q) calc();
}

import lib.math.prime_factor;

auto io = IO!()();
import lib.io;
