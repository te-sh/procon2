pure auto nsqrt(T)(T n)
{
  import std.algorithm, std.conv, std.math, std.range;
  if (n <= 1) return n;
  T m = T(1) << (n.ilogb/2+1);
  return iota(1, m).map!"a * a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
}

pure auto ncbrt(T)(T n)
{
  import std.algorithm, std.conv, std.math, std.range;
  if (n <= 1) return n;
  T m = T(1) << (n.ilogb/3+1);
  return iota(1, m).map!"a * a * a".assumeSorted!"a <= b".lowerBound(n).length.to!T;
}

/*

  n.nsqrt

    n の平方根を超えない最大の整数を返します.

  n.ncbrt

    n の立方根を超えない最大の整数を返します.

 */

unittest
{
  assert(nsqrt(1) == 1);
  assert(nsqrt(2) == 1);
  assert(nsqrt(3) == 1);
  assert(nsqrt(4) == 2);
  assert(nsqrt(5) == 2);
  assert(nsqrt(8) == 2);
  assert(nsqrt(9) == 3);

  assert(ncbrt(1) == 1);
  assert(ncbrt(2) == 1);
  assert(ncbrt(3) == 1);
  assert(ncbrt(8) == 2);
  assert(ncbrt(9) == 2);
  assert(ncbrt(26) == 2);
  assert(ncbrt(27) == 3);
}
