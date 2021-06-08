module lib.math.powr;
import std;

// :::::::::::::::::::: lib.math.powr
pure nothrow @safe
{
  /**
   ** a の n 乗を返します. 内部では繰り返し2乗法を使用しています.
   ** pred は乗法演算です.
   ** one は乗法単位元です.
   **/
  T powr(alias pred = "a*b", T, U)(const T a, U n, T one)
    if (isIntegral!U)
  {
    auto b = T(a);
    alias predFun = binaryFun!pred;
    if (n == 0) return one;
    auto r = one;
    for (; n > 0; n >>= 1) {
      if (n&1) r = predFun(r, b);
      b = predFun(b, b);
    }
    return r;
  }
  /// ditto
  T powr(alias pred = "a*b", T, U)(const T a, U n)
    if (isIntegral!U)
  {
    return powr!(pred, T, U)(a, n, T(1));
  }
}
// ::::::::::::::::::::

unittest
{
  assert(2.powr(0) == 1);
  assert(2.powr(1) == 2);
  assert(2.powr(5) == 32);
}
