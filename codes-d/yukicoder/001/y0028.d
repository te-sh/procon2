// URL: https://yukicoder.me/problems/no/28

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int Q; io.getV(Q);

  auto primes = Prime(6);
  alias Factor = primes.Factor;

  auto expo(int x, int p)
  {
    auto e = 0;
    for (; x%p == 0; x /= p) ++e;
    return e;
  }
  
  auto calc()
  {
    int seed, N, K, B; io.getV(seed, N, K, B);

    auto bd = primes.div(B);

    auto xl = new long[](N+1); xl[0] = seed;
    foreach (i; 1..N+1)
      xl[i] = 1 + (xl[i-1]^^2 + xl[i-1]*12345)%100000009;
    auto X = xl.map!"cast(int)a".array;

    auto k = 10^^9;
    foreach (i; 0..bd.length) {
      auto xd = new int[](N+1), s = 0;
      foreach (j; 0..N+1) {
	auto e = expo(X[j], bd[i].prime);
	xd[j] = e;
	s += e;
      }
      xd.sort!"a>b";
      k = min(k, (s-xd[0..N+1-K].sum)/bd[i].exp);
    }

    io.put(k);
  }

  foreach (_; 0..Q) calc();
}

import lib.math.prime;

auto io = IO!()();
import lib.io;
