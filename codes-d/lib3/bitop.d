pragma(inline)
{
  pure bool bitTest(T)(T n, size_t i) { return (n & (T(1) << i)) != 0; }
  pure T bitSet(T)(T n, size_t i) { return n | (T(1) << i); }
  pure T bitReset(T)(T n, size_t i) { return n & ~(T(1) << i); }
  pure T bitComp(T)(T n, size_t i) { return n ^ (T(1) << i); }

  import core.bitop;
  pure int bsf(T)(T n) { return core.bitop.bsf(ulong(n)); }
  pure int bsr(T)(T n) { return core.bitop.bsr(ulong(n)); }
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
auto bitSubset(bool includeZero = false, T)(T n) { return BitSubsetRange!(includeZero, T)(n); }

/*

  pure bool bitTest(T)(T n, size_t i)

    n の i ビット目が立っているかどうかを返します.

  pure T bitSet(T)(T n, size_t i)

    n の i ビット目を立てた値を返します.

  pure T bitReset(T)(T n, size_t i)

    n の i ビット目を立てない値を返します.

  pure T bitComp(T)(T n, size_t i)

    n の i ビット目を反転させた値を返します.

  pure int bsf(T)(T n)

    n のビットが立ってる最初のビットを返します.

  pure int bsr(T)(T n)

    n のビットが立ってる最後のビットを返します.

  pure int popcnt(T)(T n)

    n の立ってるビットの数を返します.

  auto bitSubset(bool includeZero = false, T)(T n)

    n のビットによる部分集合を列挙する Range を返します.
    includeZero が true ときは部分集合に 0 を含みます.

*/

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
