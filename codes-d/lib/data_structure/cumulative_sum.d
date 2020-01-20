module lib.data_structure.cumulative_sum;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.cumulative_sum
class CumulativeSum(T)
{
  const size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    s[0] = 0;
    foreach (i; 0..n) s[i+1] = s[i]+a[i];
  }

  T opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  size_t opDollar() { return n; }
}
CumulativeSum!T cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }
// ::::::::::::::::::::

/*

  class CumulativeSum(T)

    累積和を管理します.

    new CumulativeSum!T(T[] a)

      a を元に累積和を管理します.

    T c[l..r]

      区間 [l, r) の和を返します.

*/

unittest
{
  auto a = [1, 2, 3, 4, 5];
  auto cs = cumulativeSum(a);
  assert(cs[0..1] == 1);
  assert(cs[0..3] == 6);
  assert(cs[1..3] == 5);
  assert(cs[2..$] == 12);
}
