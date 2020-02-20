module lib.math.misc;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.misc
import lib.bound_by;

pure nothrow @nogc @safe
{
  /**
   ** a/b を小数点以下切り上げした値を返します.
   ** a, b は正の値を仮定しています.
   **/
  T cdiv(T)(T a, T b)
  {
    return (a+b-1)/b;
  }
  /**
   ** a/b の余りを正の範囲で返します.
   **/
  T pmod(T)(T a, T b)
  {
    return a >= 0 ? a%b : a%b+b;
  }

  /**
   ** n の平方根を超えない最大の整数を返します.
   **/
  T isqrt(T)(T n)
    if (is(T == int) || is(T == long))
  {
    static if (is(T == int)) auto max = 46_341;
    else static if (is(T == long)) auto max = 3_037_000_500L;
    return iota(T(0), max).lowerBoundBy!("a^^2", "a<=b")(n).back;
  }
  /**
   ** n の立方根を超えない最大の整数を返します.
   **/
  T icbrt(T)(T n)
    if (is(T == int) || is(T == long))
  {
    static if (is(T == int)) auto max = 1_291;
    else static if (is(T == long)) auto max = 2_097_152L;
    return iota(T(0), max).lowerBoundBy!("a^^3", "a<=b")(n).back;
  }

  /**
   ** 拡張ユークリッドの互除法で a, b の最大公約数 g を求めて返します.
   ** x, y は ax + by = g を満たす x, y の1つを返します.
   **/
  ExtGcdResult!T extGcd(T)(T a, T b)
  {
    if (a == 0) {
      return ExtGcdResult!T(b, T(0), T(1));
    } else {
      auto r = extGcd(b%a, a);
      return ExtGcdResult!T(r.gcd, r.y-(b/a)*r.x, r.x);
    }
  }

  struct ExtGcdResult(T)
  {
    T gcd, x, y;
  }
}

pure nothrow @safe
{
  /**
   ** a の n 乗を返します. 内部では繰り返し2乗法を使用しています.
   ** pred は乗法演算です.
   ** one は乗法単位元です.
   **/
  T powr(alias pred = "a*b", T, U)(T a, U n, T one)
  {
    alias predFun = binaryFun!pred;
    if (n == 0) return one;
    auto r = one;
    for (; n > 0; n >>= 1) { if (n&1) r = predFun(r, a); a = predFun(a, a); }
    return r;
  }
  /// ditto
  T powr(alias pred = "a*b", T, U)(T a, U n)
  {
    return powr!(pred, T, U)(a, n, T(1));
  }
}
// ::::::::::::::::::::

unittest
{
  assert(cdiv(5, 3) == 2);
  assert(cdiv(6, 3) == 2);
}

unittest
{
  assert(pmod(5, 3) == 2);
  assert(pmod(-5, 3) == 1);
}

unittest
{
  assert(0.isqrt == 0);
  assert(1.isqrt == 1);
  assert(2.isqrt == 1);
  assert(4.isqrt == 2);
  assert(8.isqrt == 2);
  assert(9.isqrt == 3);
  assert((2^^31-1).isqrt == 46_340);

  assert(0L.isqrt == 0L);
  assert(1L.isqrt == 1L);
  assert(2L.isqrt == 1L);
  assert(4L.isqrt == 2L);
  assert(8L.isqrt == 2L);
  assert(9L.isqrt == 3L);
  assert((2L^^63-1).isqrt == 3_037_000_499L);
}

unittest
{
  assert(0.icbrt == 0);
  assert(1.icbrt == 1);
  assert(2.icbrt == 1);
  assert(8.icbrt == 2);
  assert(26.icbrt == 2);
  assert(27.icbrt == 3);
  assert((2^^31-1).icbrt == 1_290);

  assert(0L.icbrt == 0L);
  assert(1L.icbrt == 1L);
  assert(2L.icbrt == 1L);
  assert(8L.icbrt == 2L);
  assert(26L.icbrt == 2L);
  assert(27L.icbrt == 3L);
  assert((2L^^63-1).icbrt == 2_097_151L);
}

unittest
{
  auto r1 = extGcd(29, 17);
  assert(r1.gcd == 1 && r1.x == -7 && r1.y == 12);

  auto r2 = extGcd(12, 42);
  assert(r2.gcd == 6 && r2.x == -3 && r2.y == 1);
}

unittest
{
  assert(2.powr(0) == 1);
  assert(2.powr(1) == 2);
  assert(2.powr(5) == 32);
}
