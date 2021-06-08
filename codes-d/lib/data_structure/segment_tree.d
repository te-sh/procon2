module lib.data_structure.segment_tree;
import std;

// :::::::::::::::::::: lib.data_structure.segment_tree
/**
 ** Segment Tree を表します.
 ** pred は合成関数です.
 **/
class SegmentTree(alias pred = "a+b", T)
{
  alias predFun = binaryFun!pred;
  /**
   ** 要素数です.
   **/
  const size_t n;
  /**
   ** すべての要素を配列で返します.
   **/
  @property T[] data() { return buf[an..an+n]; }

  pure nothrow @safe
  {
    /**
     ** 要素数 n の Segment Tree を返します.
     ** dflt は値がない要素のデフォルト値です.
     **/
    this(size_t n, T dflt = T.init)
    {
      this.n = n;
      this.dflt = dflt;
      an = n == 1 ? 1 : (n-1).nextPow2;
      buf = new T[](an*2);

      if (T.init != dflt) {
        buf[an..an+n][] = dflt;
        propagateAll();
      }
    }

    /**
     ** init を元にした Segment Tree を返します.
     ** dflt は値がない要素のデフォルト値です.
     **/
    this(T[] init, T dflt = T.init)
    {
      this.n = init.length;
      this.dflt = dflt;
      an = (n-1).nextPow2;
      buf = new T[](an*2);

      buf[an..an+n][] = init[];
      propagateAll();
    }
  }

  pure nothrow @nogc @safe
  {
    /**
     ** インデックス i の値を val に変更します.
     **/
    void opIndexAssign(T val, size_t i)
      in { assert(0 <= i && i < n); }
    do
    {
      buf[i+=an] = val; propagate(i);
    }

    /**
     ** インデックス i の値を演算子 op を値 val で適用したしたものに変更します.
     **/
    void opIndexOpAssign(string op)(T val, size_t i)
      in { assert(0 <= i && i < n); }
    do
    {
      mixin("buf[i+=an]"~op~"=val;");
      propagate(i);
    }

    /**
     ** インデックス i の値を 1 だけ加算/減算します.
     **/
    void opIndexUnary(string op)(size_t i)
      if (op == "++" || op == "--")
      in { assert(0 <= i && i < n); }
    do
    {
      mixin(op~"buf[i+=an];");
      propagate(i);
    }

    /**
     ** インデックス i の値を返します.
     **/
    T opIndex(size_t i)
      in { assert(0 <= i && i < n); }
    do
    {
      return buf[i+an];
    }

    /**
     ** 区間 [l, r) の合成値を返します.
     **/
    T opSlice(size_t l, size_t r)
      in { assert(0 <= l && l <= r && r <= n); }
    do
    {
      l += an; r += an;
      T r1 = dflt, r2 = dflt;
      while (l != r) {
        if (l % 2) r1 = predFun(r1, buf[l++]);
        if (r % 2) r2 = predFun(buf[--r], r2);
        l /= 2; r /= 2;
      }
      return predFun(r1, r2);
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
    const size_t an;
    const T dflt;
    T[] buf;

    pure nothrow @nogc @safe
    {
      void propagateAll()
      {
        foreach_reverse (i; 1..an)
          buf[i] = predFun(buf[i*2], buf[i*2+1]);
      }
      void propagate(size_t i)
      {
        while (i /= 2)
          buf[i] = predFun(buf[i*2], buf[i*2+1]);
      }
    }
  }
}

pure nothrow @safe
{
  /**
   ** 要素数 n の Segment Tree を返します.
   ** pred は合成関数です.
   ** dflt は値がない要素のデフォルト値です.
   **/
  auto segmentTree(alias pred = "a+b", T)(size_t n, T dflt = T.init)
  {
    return new SegmentTree!(pred, T)(n, dflt);
  }
  /**
   ** init を元にした Segment Tree を返します.
   ** pred は合成関数です.
   ** dflt は値がない要素のデフォルト値です.
   **/
  auto segmentTree(alias pred = "a+b", T)(T[] init, T dflt = T.init)
  {
    return new SegmentTree!(pred, T)(init, dflt);
  }
}
// ::::::::::::::::::::

unittest
{
  auto st1 = segmentTree!("a+b", int)(6);
  st1[0] = 1;
  st1[2] = 2;
  st1[5] = 5;
  assert(st1[0] == 1);
  assert(st1[2] == 2);
  assert(st1[5] == 5);
  assert(equal(st1.data, [1, 0, 2, 0, 0, 5]));
  assert(st1[0..0] == 0);
  assert(st1[0..1] == 1);
  assert(st1[0..2] == 1);
  assert(st1[0..3] == 3);
  assert(st1[2..$] == 7);
  ++st1[2];
  assert(st1[0..3] == 4);
  assert(st1[2..$] == 8);

  auto st2 = segmentTree!min(10, int.max);
  st2[0] = 8;
  st2[2] = 4;
  st2[5] = 5;
  assert(st2[0..0] == int.max);
  assert(st2[0..1] == 8);
  assert(st2[0..2] == 8);
  assert(st2[0..3] == 4);
  assert(st2[2..$] == 4);
  st2[2] += 5;
  assert(st2[0..3] == 8);
  assert(st2[2..$] == 5);

  auto st3 = segmentTree(iota(1, 11).array);
  assert(st3[0..0] == 0);
  assert(st3[0..1] == 1);
  assert(st3[0..2] == 3);
  assert(st3[0..3] == 6);
  assert(st3[2..$] == 52);
}
