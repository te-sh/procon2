module lib.data_structure.fenwick_tree;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.data_structure.fenwick_tree
/**
 ** Fenwick Tree を表します.
 **/
class FenwickTree(T)
{
  /**
   ** 要素数です.
   **/
  const size_t n;

  /**
   ** 要素数が n の Fenwick Tree を返します.
   **/
  pure nothrow @safe this(size_t n) { this.n = n; this.buf = new T[](n+1); }

  pure nothrow @nogc @safe
  {
    /**
     ** インデックス i の値を値 val だけ加算/減算します.
     **/
    void opIndexOpAssign(string op)(T val, size_t i) if (op=="+"||op=="-")
    { ++i; for (; i <= n; i += i&-i) mixin("buf[i]"~op~"=val;"); }

    /**
     ** インデックス i の値を 1 だけ加算/減算します.
     **/
    void opIndexUnary(string op)(size_t i) if (op=="++"||op=="--")
    { ++i; for (; i <= n; i += i&-i) mixin(op~"buf[i];"); }

    /**
     ** インデックス i の値を返します.
     **/
    T opIndex(size_t i) { return opSlice(i, i+1); }
    /**
     ** 区間 [l, r) の和を返します.
     **/
    T opSlice(size_t r, size_t l) { return get(l) - get(r); }
    /**
     ** 要素数を返します.
     **/
    size_t opDollar() { return n; }
  }

  private
  {
    T[] buf;

    pure nothrow @nogc @safe T get(size_t i)
    {
      auto s = T(0);
      for (; i > 0; i -= i & -i) s += buf[i];
      return s;
    }
  }
}
/**
 ** 要素数が n の Fenwick Tree を返します.
 **/
pure nothrow @safe FenwickTree!T fenwickTree(T)(size_t n) { return new FenwickTree!T(n); }
// ::::::::::::::::::::

unittest
{
  auto ft = fenwickTree!int(15);

  assert(ft[0..2] == 0);
  assert(ft[0..3] == 0);
  assert(ft[0..6] == 0);
  assert(ft[5..$] == 0);

  ft[1] += 2;

  assert(ft[1] == 2);
  assert(ft[0..2] == 2);
  assert(ft[0..3] == 2);
  assert(ft[0..6] == 2);
  assert(ft[5..$] == 0);

  ft[2] += 3;
  ft[5] += 4;
  ft[10] -= 5;
  ft[14] += 2;

  assert(ft[0..2] == 2);
  assert(ft[0..3] == 5);
  assert(ft[0..6] == 9);
  assert(ft[5..$] == 1);

  ++ft[10];

  assert(ft[5..$] == 2);
}
