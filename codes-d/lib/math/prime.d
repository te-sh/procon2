module lib.math.prime;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.math.prime
import lib.math.misc;

/**
 ** 素数を列挙します.
 **/
struct Prime
{
  import std.bitmanip, std.traits;
  /**
   ** 素因数 prime とベキ指数 exp を表します.
   **/
  struct Factor(T) { T prime; int exp; }

  /**
   ** この構造体は n 以下の素数を保持します.
   **/
  const int n;
  /**
   ** 素数の配列を返します.
   **/
  @property array() { return primes; }
  alias array this;

  pure nothrow
  {
    /**
     ** n 以下の素数を保持する構造体を返します.
     **/
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
  }

  pure nothrow @safe
  {
    /**
     ** x の素因数分解を行い, 結果を Factor の配列で返します.
     ** x は n^2 より小さい必要があります.
     **/
    Factor!T[] div(T)(T x)
      if (isIntegral!T)
      in { assert(x > 0 && x.isqrt <= n); }
    do
    {
      Factor!T[] factors;
      auto t = isqrt(x);
      foreach (p; primes) {
        if (p > t) break;
        auto c = 0;
        for (; x%p == 0; x /= p) ++c;
        if (c > 0) factors ~= Factor!T(p, c);
        if (x == 1) break;
      }
      if (x > 1) factors ~= [Factor!T(x, 1)];
      return factors;
    }

    /**
     ** x の約数の配列を返します.
     ** x は n^2 より小さい必要があります.
     **/
    T[] divisors(T)(T x)
      if (isIntegral!T)
      in { assert(x > 0 && x.isqrt <= n); }
    do
    {
      auto factors = div(x);
      auto r = divisorsProc(factors, 0, 1);
      r.sort();
      return r;
    }
  }

  private
  {
    int[] primes;

    pure nothrow @safe
    {
      T[] divisorsProc(T)(Factor!T[] factors, int i, T c)
      {
        if (i == factors.length) return [c];
        T[] r;
        foreach (j; 0..factors[i].exp+1)
          r ~= divisorsProc(factors, i+1, c*factors[i].prime^^j);
        return r;
      }
    }
  }
}
// ::::::::::::::::::::

unittest
{
  assert(equal(Prime(2).array, [2]));
  assert(equal(Prime(5).array, [2, 3, 5]));
  assert(equal(Prime(30).array, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]));

  auto primes = Prime(5);
  alias Factor = primes.Factor!int;

  assert(equal(primes.div(23), [Factor(23, 1)]));
  assert(equal(primes.div(24), [Factor(2, 3), Factor(3, 1)]));
  assert(equal(primes.div(25), [Factor(5, 2)]));
  assert(equal(primes.div(31), [Factor(31, 1)]));

  auto primes2 = Prime(100);
  assert(equal(primes2.divisors(60), [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60]));
}
