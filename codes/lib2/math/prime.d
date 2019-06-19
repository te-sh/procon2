struct Prime
{
  import std.algorithm, std.bitmanip, std.math, std.range, std.typecons;
  alias Factor = Tuple!(int, size_t);

  int n;
  int[] primes;
  alias primes this;

  this(int n)
  {
    this.n = n;

    auto sieve = BitArray();
    sieve.length((n+1)/2);
    sieve = ~sieve;

    foreach (p; 1..((nsqrt(n)-1)/2+1))
      if (sieve[p])
        for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
          sieve[q] = false;

    primes = sieve.bitsSet.map!(p => cast(int)p*2+1).array;
    primes[0] = 2;
  }

  pure auto div(int x)
  in { assert(x > 0 && nsqrt(x) <= n); }
  body {
    Factor[] factors;
    auto t = nsqrt(x);
    foreach (p; primes) {
      if (p > t) {
        factors ~= Factor(x, 1);
        break;
      }
      auto c = size_t(0);
      for (; x%p == 0; x /= p) ++c;
      if (c > 0) factors ~= Factor(p, c);
      if (x == 1) break;
    }
    return factors;
  }

  pure auto divisors(int x)
  in { assert(x > 0 && nsqrt(x) <= n); }
  body {
    auto factors = div(x);
    auto r = divisorsProc(factors, 0, 1);
    r.sort();
    return r;
  }

  pure int[] divisorsProc(Factor[] factors, size_t i, int c)
  {
    if (i == factors.length) return [c];
    int[] r;
    foreach (j; 0..factors[i][1]+1)
      r ~= divisorsProc(factors, i+1, c*factors[i][0]^^cast(int)j);
    return r;
  }

  pure auto nsqrt(int n)
  {
    if (n <= 1) return n;
    auto m = 1<<(n.ilogb/2+1);
    return cast(int)iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length;
  }
}

/*

  Prime

    素数を保持する構造体です.

  Prime(n)

    n 以下の素数を返します.

  primes.div(x)

    x を素因数分解して, (素因数, べき乗数) の Tuple の配列で返します.
    x は n^2 より小さい必要があります.

  prime.divisors(x)

    x の約数の配列を返します.
    x は n^2 より小さい必要があります.

 */

unittest
{
  import std.typecons;

  assert(Prime(2) == [2]);
  assert(Prime(5) == [2, 3, 5]);
  assert(Prime(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]);

  alias Factor = Tuple!(int, size_t);
  auto p1 = Prime(5);

  assert(p1.div(23) == [Factor(23, 1)]);
  assert(p1.div(24) == [Factor(2, 3), Factor(3, 1)]);
  assert(p1.div(25) == [Factor(5, 2)]);

  auto p2 = Prime(100);
  assert(p2.divisors(1500) == [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 25, 30, 50, 60, 75, 100, 125, 150, 250, 300, 375, 500, 750, 1500]);
}
