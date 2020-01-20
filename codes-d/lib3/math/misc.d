import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

pure T isqrt(T)(T n)
{
  static if (is(T == int)) auto max = 46340;
  else static if (is(T == long)) auto max = 3037000499L;
  auto bs = iota(T(0), max).map!(x => tuple(x, x^^2)).assumeSorted!"a[1]<=b[1]";
  return bs.lowerBound(tuple(0, n)).back[0];
}

pure T icbrt(T)(T n)
{
  static if (is(T == int)) auto max = 1290;
  else static if (is(T == long)) auto max = 2097151L;
  auto bs = iota(T(0), max).map!(x => tuple(x, x^^3)).assumeSorted!"a[1]<=b[1]";
  return bs.lowerBound(tuple(0, n)).back[0];
}

pure T powr(alias pred = "a*b", T, U)(T a, U n, T one)
{
  import std.functional;
  alias predFun = binaryFun!pred;
  if (n == 0) return one;
  auto r = one;
  for (; n > 0; n >>= 1) { if (n&1) r = predFun(r, a); a = predFun(a, a); }
  return r;
}
pure T powr(alias pred = "a*b", T, U)(T a, U n) { return powr!(pred, T, U)(a, n, T(1)); }

pure T extGcd(T)(T a, T b, out T x, out T y)
{
  auto g = a; x = 1; y = 0;
  if (b) { g = extGcd(b, a%b, y, x); y -= a/b*x; }
  return g;
}

/*

  pure T isqrt(T)(T n)

    n の平方根を超えない最大の整数を返します.

  pure T icbrt(T)(T n)

    n の立方根を超えない最大の整数を返します.

  pure T powr(alias pred = "a*b", T, U)(T a, U n)
  pure T powr(alias pred = "a*b", T, U)(T a, U n, T one)

    a の n 乗を返します. 内部では繰り返し2乗法を使用しています.
    one には乗法単位元を指定します. (デフォルト値は 1 です)
    pred には乗法演算を指定します.

  pure T extGcd(T)(T a, T b, out T x, out T y)

    拡張ユークリッドの互除法で a, b の最大公約数 g を求めて返します.
    x, y は ax + by = g を満たす x, y の1つを返します.

*/

unittest
{
  assert(0.isqrt == 0);
  assert(1.isqrt == 1);
  assert(2.isqrt == 1);
  assert(4.isqrt == 2);
  assert(8.isqrt == 2);
  assert(9.isqrt == 3);
  assert((2^^31-1).isqrt == 46340);

  assert(0L.isqrt == 0L);
  assert(1L.isqrt == 1L);
  assert(2L.isqrt == 1L);
  assert(4L.isqrt == 2L);
  assert(8L.isqrt == 2L);
  assert(9L.isqrt == 3L);
  assert((2L^^63-1).isqrt == 3037000499L);
}

unittest
{
  assert(0.icbrt == 0);
  assert(1.icbrt == 1);
  assert(2.icbrt == 1);
  assert(8.icbrt == 2);
  assert(26.icbrt == 2);
  assert(27.icbrt == 3);
  assert((2^^31-1).icbrt == 1290);

  assert(0L.icbrt == 0L);
  assert(1L.icbrt == 1L);
  assert(2L.icbrt == 1L);
  assert(8L.icbrt == 2L);
  assert(26L.icbrt == 2L);
  assert(27L.icbrt == 3L);
  assert((2L^^63-1).icbrt == 2097151L);
}

unittest
{
  assert(2.powr(0) == 1);
  assert(2.powr(1) == 2);
  assert(2.powr(5) == 32);
}

unittest
{
  int x, y, g;

  g = extGcd(29, 17, x, y);
  assert(g == 1 && x == -7 && y == 12);

  g = extGcd(12, 42, x, y);
  assert(g == 6 && x == -3 && y == 1);
}
