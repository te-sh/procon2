module lib.bitop;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

// :::::::::::::::::::: lib.bitop
pragma(inline)
{
  import core.bitop;
  /**
   ** n の i ビット目が 1 かどうかを返します.
   **/
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  /**
   ** n の i ビット目を 1 にした結果の数値を返します.
   **/
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  /**
   ** n の i ビット目を 0 にした結果の数値を返します.
   **/
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  /**
   ** n の i ビット目を反転させた結果の数値を返します.
   **/
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }
  /**
   ** n の最初に 1 になっているビットを返します.
   **/
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  /**
   ** n の最後に 1 になっているビットを返します.
   **/
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
  /**
   ** n の 1 になっているビットの数を返します.
   **/
  pure int popcnt(T)(T n) { return core.bitop.popcnt(ulong(n)); }
}

struct BitSubsetRange(bool includeZero = false, T)
{
  T n, i;

  this(T n) { this.n = this.i = n; }
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
/**
 ** n のビットによる部分集合になっている数値を列挙して Range で返します.
 ** includeZero が true の場合は部分集合に 0 を含めます.
 **/
auto bitSubset(bool includeZero = false, T)(T n) { return BitSubsetRange!(includeZero, T)(n); }
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
  assert(bsr(6) == 2);
  assert(popcnt(6) == 2);

  import std.algorithm;
  assert(equal(bitSubset(11), [11, 10, 9, 8, 3, 2, 1]));
  assert(equal(bitSubset!true(11), [11, 10, 9, 8, 3, 2, 1, 0]));
}
