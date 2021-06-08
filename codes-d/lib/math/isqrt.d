module lib.math.isqrt;
import std;

// :::::::::::::::::::: lib.math.misc
import lib.bound_by;

pure nothrow @nogc @safe
{
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
}
// ::::::::::::::::::::

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
