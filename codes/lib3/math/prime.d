import misc;

struct Prime
{
  import std.algorithm, std.bitmanip, std.math, std.range, std.typecons;
  alias Factor = Tuple!(int, int);

  int n;
  int[] primes;
  alias primes this;

  this(int n)
  {
    this.n = n;

    auto sieve = BitArray();
    sieve.length((n+1)/2);
    sieve = ~sieve;

    foreach (p; 1..(n.isqrt-1)/2+1)
      if (sieve[p])
        for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
          sieve[q] = false;

    primes = sieve.bitsSet.map!(p => cast(int)p*2+1).array;
    primes[0] = 2;
  }

  pure Factor[] div(int x) in { assert(x > 0 && x.isqrt <= n); } do
  {
    Factor[] factors;
    auto t = isqrt(x);
    foreach (p; primes) {
      if (p > t) {
        factors ~= Factor(x, 1);
        break;
      }
      auto c = 0;
      for (; x%p == 0; x /= p) ++c;
      if (c > 0) factors ~= Factor(p, c);
      if (x == 1) break;
    }
    return factors;
  }

  pure int[] divisors(int x) in { assert(x > 0 && x.isqrt <= n); } do
  {
    auto factors = div(x);
    auto r = divisorsProc(factors, 0, 1);
    r.sort();
    return r;
  }

private:

  pure int[] divisorsProc(Factor[] factors, int i, int c)
  {
    if (i == factors.length) return [c];
    int[] r;
    foreach (j; 0..factors[i][1]+1)
      r ~= divisorsProc(factors, i+1, c*factors[i][0]^^j);
    return r;
  }
}


/*

  Prime

    素数を保持します.

    Factor

      (素因数, べき乗数) を表すタプルです.

    this(int n)

      n 以下の素数を計算して primes にセットします.

    pure Factor[] div(int x)

      x を素因数分解して Factor の配列で返します
      x は n^2 より小さい必要があります.

    pure int[] divisors(int x)

      x の約数の配列を返します.
      x は n^2 より小さい必要があります.

*/

unittest
{
  import std.algorithm;
  assert(equal(Prime(2), [2]));
  assert(equal(Prime(5), [2, 3, 5]));
  assert(equal(Prime(30), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]));

  auto primes = Prime(5);
  alias Factor = primes.Factor;

  assert(equal(primes.div(23), [Factor(23, 1)]));
  assert(equal(primes.div(24), [Factor(2, 3), Factor(3, 1)]));
  assert(equal(primes.div(25), [Factor(5, 2)]));

  auto primes2 = Prime(100);
  assert(equal(primes2.divisors(60), [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60]));
}
