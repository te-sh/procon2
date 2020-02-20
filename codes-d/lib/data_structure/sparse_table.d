module lib.data_structure.sparse_table;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.data_structure.sparse_table
/**
 ** Sparse Table を表します.
 ** pred は合成関数です.
 **/
class SparseTable(alias pred = min, T)
{
  alias predFun = binaryFun!pred;
  /**
   ** 要素数です.
   **/
  const size_t n;

  pure nothrow @safe
  {
    /**
     ** a を元にした Sparse Table を返します.
     **/
    this(T[] a)
    {
      this.n = a.length;
      this.a = a;

      logTable = new size_t[n+1];
      foreach (i; 2..n+1)
        logTable[i] = logTable[i>>1]+1;

      rmq = new size_t[][](logTable[n]+1, n);

      foreach (i; 0..n) rmq[0][i] = i;

      for (size_t k = 1; (1<<k) < n; ++k)
        for (size_t i = 0; i+(1<<k) <= n; ++i) {
          auto x = rmq[k-1][i];
          auto y = rmq[k-1][i+(1<<k-1)];
          rmq[k][i] = predFun(a[x], a[y]) == a[x] ? x : y;
        }
    }
  }

  pure nothrow @nogc @safe
  {
    /**
     ** 区間 [l, r) の合成値を返します.
     **/
    T opSlice(size_t l, size_t r)
      in { assert(0 <= l && l <= r && r <= n); }
    do
    {
      auto k = logTable[r-l-1];
      auto x = rmq[k][l];
      auto y = rmq[k][r-(1<<k)];
      return predFun(a[x], a[y]);
    }

    /**
     ** 要素数を返します.
     **/
    size_t opDollar()
    {
      return n;
    }
  }

  private
  {
    T[] a;
    size_t[] logTable;
    size_t[][] rmq;
  }
}

pure nothrow @safe
{
  /**
   ** a を元にした Sparse Table を返します.
   ** pred は合成関数です.
   **/
  auto sparseTable(alias pred = min, T)(T[] a)
  {
    return new SparseTable!(pred, T)(a);
  }
}
// ::::::::::::::::::::

unittest
{
  auto a = [1, 5, 9, 2, 4, 1, 3];

  auto st1 = sparseTable(a);
  assert(st1[0..1] == 1);
  assert(st1[0..3] == 1);
  assert(st1[1..4] == 2);
  assert(st1[4..$] == 1);

  auto st2 = sparseTable!max(a);
  assert(st2[0..1] == 1);
  assert(st2[0..3] == 9);
  assert(st2[1..4] == 9);
  assert(st2[4..$] == 4);
}
