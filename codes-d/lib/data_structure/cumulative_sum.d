module lib.data_structure.cumulative_sum;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.data_structure.cumulative_sum
/**
 ** 配列の累積和を表します.
 **/
class CumulativeSum(T)
{
  /**
   ** 配列の要素数です.
   **/
  const size_t n;
  /**
   ** 配列の累積和です.
   **/
  T[] s;

  /**
   ** 配列 a の累積和の計算結果を保持する構造体を返します.
   **/
  pure nothrow @safe
  {
    this(T[] a)
    {
      n = a.length;
      s = new T[](n+1);
      s[0] = 0;
      foreach (i; 0..n) s[i+1] = s[i]+a[i];
    }
  }

  pure nothrow @nogc @safe
  {
    /**
     ** 配列の区間 [l, r) の和を返します.
     **/
    T opSlice(size_t l, size_t r)
      in { assert(0 <= l && l <= r && r <= n); }
    do
    {
      return s[r]-s[l];
    }
    /**
     ** 配列の要素数を返します.
     **/
    size_t opDollar()
    {
      return n;
    }
  }
}

pure nothrow @safe
{
  /**
   ** 配列 a の累積和の計算結果を保持する構造体を返します.
   **/
  auto cumulativeSum(T)(T[] a)
  {
    return new CumulativeSum!T(a);
  }
}
// ::::::::::::::::::::

unittest
{
  auto a = [1, 2, 3, 4, 5];
  auto cs = cumulativeSum(a);
  assert(cs[0..1] == 1);
  assert(cs[0..3] == 6);
  assert(cs[1..3] == 5);
  assert(cs[2..$] == 12);
}
