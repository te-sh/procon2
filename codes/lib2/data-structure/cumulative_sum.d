class CumulativeSum(T)
{
  size_t n;
  T[] s;

  this(T[] a)
  {
    n = a.length;
    s = new T[](n+1);
    static if (T.init != 0) s[0] = T(0);
    foreach (i; 0..n) s[i+1] = s[i] + a[i];
  }

  pure auto opSlice(size_t l, size_t r) { return s[r]-s[l]; }
  pure auto opDollar() { return n; }
}
auto cumulativeSum(T)(T[] a) { return new CumulativeSum!T(a); }

/*

  CumulativeSum!T

    累積和を保持する構造体です.

  a.cumulativeSum

    a の累積和を計算し, 保持します.

  c[l..r]

    a の区間 [l, r) の和を計算します.

 */

unittest
{
  auto a = [1, 2, 3, 4, 5];
  auto cs = a.cumulativeSum;
  assert(cs[0..1] == 1);
  assert(cs[0..3] == 6);
  assert(cs[1..3] == 5);
  assert(cs[2..$] == 12);
}
