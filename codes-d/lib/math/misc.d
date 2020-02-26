module lib.math.misc;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.math.misc
pragma(inline) pure nothrow @nogc @safe
{
  /**
   ** a/b を小数点以下切り上げした値を返します.
   ** a, b は正の値を仮定しています.
   **/
  T cdiv(T)(const T a, const T b)
  {
    return (a+b-1)/b;
  }
  /**
   ** a/b の余りを正の範囲で返します.
   **/
  T pmod(T)(const T a, const T b)
  {
    return a >= 0 ? a%b : a%b+b;
  }
}

pure nothrow @nogc @safe
{
  /**
   ** 拡張ユークリッドの互除法で a, b の最大公約数 g を求めて返します.
   ** x, y は ax + by = g を満たす x, y の1つを返します.
   **/
  ExtGcdResult!T extGcd(T)(const T a, const T b)
  {
    if (a == 0) {
      return ExtGcdResult!T(T(b), T(0), T(1));
    } else {
      auto r = extGcd(b%a, a);
      return ExtGcdResult!T(r.gcd, r.y-(b/a)*r.x, r.x);
    }
  }

  private struct ExtGcdResult(T)
  {
    T gcd, x, y;
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
  auto r1 = extGcd(29, 17);
  assert(r1.gcd == 1 && r1.x == -7 && r1.y == 12);

  auto r2 = extGcd(12, 42);
  assert(r2.gcd == 6 && r2.x == -3 && r2.y == 1);
}
