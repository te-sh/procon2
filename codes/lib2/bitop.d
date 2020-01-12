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

/*

  n.bitTest(i)

    n の i ビット目が立っているかどうかを返します.

  n.bitSet(i)

    n の i ビットを立てた値を返します.

  n.bitReset(i)

    n の i ビットを立てない値を返します.

  n.bitComp(i)

    n の i ビットを反転させた値を返します.

  n.bsf

    n のビットが立ってる最初のビットを返します.

  n.bsr

    n のビットが立ってる最後のビットを返します.

  n.popcnt

    n の立ってるビットの数を返します.

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
}
