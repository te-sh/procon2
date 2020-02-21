module lib.math.prime_factor;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.prime_factor
import lib.math.isqrt;

/**
 ** 素数を列挙と素因数分解を行う構造体です.
 **/
struct PrimeFactor
{
  /**
   ** 素因数とベキ指数を表します.
   **/
  struct Factor(T)
  {
    /**
     ** 素因数です.
     **/
    T prime;
    /**
     ** 素因数とベキ指数です.
     **/
    int exp;
  }

  /**
   ** この構造体は n 以下の素数を保持します.
   **/
  const int n;
  /**
   ** 素数の配列です.
   **/
  int[] primes;

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
    Factor!T[] div(T)(T x) const
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
    T[] divisors(T)(T x) const
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
    pure nothrow @safe
    {
      T[] divisorsProc(T)(Factor!T[] factors, int i, T c) const
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

pure nothrow
{
  /**
   ** n 以下の素数を保持する PrimeFactor 構造体を返します.
   **/
  auto primeFactor(int n)
  {
    return PrimeFactor(n);
  }

  /**
   ** √n 以下の素数を保持する PrimeFactor 構造体を返します.
   ** n 以下の数の素因数分解を行うために使用することが多いでしょう.
   **/
  auto primeFactorSqrtOf(T)(T n)
    if (isIntegral!T)
  {
    return PrimeFactor(cast(int)n.isqrt);
  }
}
// ::::::::::::::::::::

unittest
{
  assert(equal(PrimeFactor(2).primes, [2]));
  assert(equal(PrimeFactor(5).primes, [2, 3, 5]));
  assert(equal(PrimeFactor(30).primes, [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]));

  auto pf = PrimeFactor(5);
  alias Factor = pf.Factor!int;

  assert(equal(pf.div(23), [Factor(23, 1)]));
  assert(equal(pf.div(24), [Factor(2, 3), Factor(3, 1)]));
  assert(equal(pf.div(25), [Factor(5, 2)]));
  assert(equal(pf.div(31), [Factor(31, 1)]));

  auto pf2 = PrimeFactor(100);
  assert(equal(pf2.divisors(60), [1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60]));

  assert(primeFactor(120).n == 120);
  assert(primeFactorSqrtOf(120).n == 10);
}
