struct Prime(T)
{
  import std.algorithm, std.bitmanip, std.conv, std.math, std.range, std.typecons;
  alias Factor = Tuple!(T, size_t);

  T n;
  T[] primes;
  alias primes this;

  auto this(T n)
  {
    this.n = n;

    auto sieve = BitArray();
    sieve.length((n+1)/2);
    sieve = ~sieve;

    foreach (p; 1..((nsqrt(n)-1)/2+1))
      if (sieve[p])
        for (auto q = p*3+1; q < (n+1)/2; q += p*2+1)
          sieve[q] = false;

    primes = sieve.bitsSet.map!(to!T).map!("a*2+1").array;
    primes[0] = 2;
  }

  pure auto div(T x)
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

  pure auto nsqrt(T)(T n)
  {
    if (n <= 1) return n;
    T m = T(1) << (n.ilogb/2+1);
    return iota(1, m).map!"a*a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
  }
}
auto prime(T)(T n) { return Prime!T(n); }

/*

  Prime!T

    素数を保持する構造体です.

  prime(n)

    n 以下の素数を返します.

  primes.div(x)

    x を素因数分解して, (素因数, べき乗数) の Tuple の配列で返します.
    x は n^2 より小さい必要があります.

 */

unittest
{
  import std.typecons;

  assert(prime(2) == [2]);
  assert(prime(5) == [2, 3, 5]);
  assert(prime(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]);

  alias Factor = Tuple!(int, size_t);
  auto p1 = prime(5);

  assert(p1.div(23) == [Factor(23, 1)]);
  assert(p1.div(24) == [Factor(2, 3), Factor(3, 1)]);
  assert(p1.div(25) == [Factor(5, 2)]);
}
