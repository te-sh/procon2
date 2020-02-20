module lib.bitop;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.bitop
pragma(inline)
{
  import core.bitop : _bsf = bsf, _bsr = bsr, _popcnt = popcnt;
  pure nothrow @nogc @safe
  {
    /**
     ** n の i ビット目が 1 かどうかを返します.
     **/
    bool bitTest(T)(T n, size_t i)
      if (isIntegral!T)
    { return (n & (T(1) << i)) != 0; }
    /**
     ** n の i ビット目を 1 にした結果の数値を返します.
     **/
    T bitSet(T)(T n, size_t i)
      if (isIntegral!T)
    { return n | (T(1) << i); }
    /**
     ** n の i ビット目を 0 にした結果の数値を返します.
     **/
    T bitReset(T)(T n, size_t i)
      if (isIntegral!T)
    { return n & ~(T(1) << i); }
    /**
     ** n の i ビット目を反転させた結果の数値を返します.
     **/
    T bitComp(T)(T n, size_t i)
      if (isIntegral!T)
    { return n ^ (T(1) << i); }
    /**
     ** n の最初に 1 になっているビットを返します.
     **/
    int bsf(T)(T n)
      if (is(T == int) || is(T == uint))
    { return _bsf(cast(uint)(n)); }
    /// ditto
    int bsf(T)(T n)
      if (is(T == long) || is(T == ulong))
    { return _bsf(cast(ulong)(n)); }
    /**
     ** n の最後に 1 になっているビットを返します.
     **/
    int bsr(T)(T n)
      if (is(T == int) || is(T == uint))
    { return _bsr(cast(uint)n); }
    /// ditto
    int bsr(T)(T n)
      if (is(T == long) || is(T == ulong))
    { return _bsr(cast(ulong)n); }
    /**
     ** n の 1 になっているビットの数を返します.
     **/
    int popcnt(T)(T n)
      if (is(T == int) || is(T == uint))
    { return _popcnt(cast(uint)n); }
    /// ditto
    int popcnt(T)(T n)
      if (is(T == long) || is(T == ulong))
    { return _popcnt(cast(ulong)n); }
  }
}

struct BitSubsetRange(bool includeZero = false, T)
{
  private T n, i;

  this(T n) { this.n = this.i = n; }
  pure nothrow @nogc @safe
  {
    static if (includeZero) {
      @property T front() { return i&n; }
      void popFront() { i &= n; i--; }
      bool empty() { return i < 0; }
    } else {
      @property T front() { return i; }
      void popFront() { i = (i-1)&n; }
      bool empty() { return i <= 0; }
    }
  }
}
/**
 ** n のビットによる部分集合になっている数値を列挙して Range で返します.
 ** includeZero が true の場合は部分集合に 0 を含めます.
 **/
pure nothrow @nogc @safe BitSubsetRange!(includeZero, T) bitSubset(bool includeZero = false, T)(T n)
{
  return BitSubsetRange!(includeZero, T)(n);
}
// ::::::::::::::::::::

unittest
{
  assert(bitTest(2, 1));
  assert(!bitTest(2, 2));
  assert(bitSet(4, 1) == 6);
  assert(bitSet(6, 1) == 6);
  assert(bitReset(4, 1) == 4);
  assert(bitReset(6, 1) == 4);
  assert(bitComp(4, 1) == 6);
  assert(bitComp(6, 1) == 4);
  assert(bsf(6) == 1);
  assert(bsf(6L) == 1);
  assert(bsr(6) == 2);
  assert(bsr(6L) == 2);
  assert(popcnt(6) == 2);
  assert(popcnt(6L) == 2);

  assert(equal(bitSubset(11), [11, 10, 9, 8, 3, 2, 1]));
  assert(equal(bitSubset!true(11), [11, 10, 9, 8, 3, 2, 1, 0]));
}
