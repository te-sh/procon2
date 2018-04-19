class SegmentTree(T, alias pred = "a + b")
{
  import core.bitop, std.functional;
  alias predFun = binaryFun!pred;

  const size_t n, an;
  T[] buf;
  T unit;

  this(size_t n, T unit = T.init)
  {
    this.n = n;
    this.unit = unit;
    an = n == 1 ? 1 : (1 << ((n-1).bsr + 1));
    buf = new T[](an*2);
    if (T.init != unit) buf[] = unit;
  }

  this(T[] init, T unit = T.init)
  {
    this(init.length, unit);
    buf[an..an+n][] = init[];
    foreach_reverse (i; 1..an)
      buf[i] = predFun(buf[i*2], buf[i*2+1]);
  }

  void opIndexAssign(T val, size_t i)
  {
    buf[i += an] = val;
    while (i /= 2)
      buf[i] = predFun(buf[i*2], buf[i*2+1]);
  }

  pure T opSlice(size_t l, size_t r)
  {
    l += an; r += an;
    T r1 = unit, r2 = unit;
    while (l != r) {
      if (l % 2) r1 = predFun(r1, buf[l++]);
      if (r % 2) r2 = predFun(buf[--r], r2);
      l /= 2; r /= 2;
    }
    return predFun(r1, r2);
  }

  pure T opIndex(size_t i) { return buf[i+an]; }
  pure size_t opDollar() { return n; }
}

unittest
{
  import std.algorithm;

  auto st1 = new SegmentTree!(int, "a + b")(6);
  st1[0] = 1;
  st1[2] = 2;
  st1[5] = 5;
  assert(st1[0] == 1);
  assert(st1[2] == 2);
  assert(st1[5] == 5);
  assert(st1[0..0] == 0);
  assert(st1[0..1] == 1);
  assert(st1[0..2] == 1);
  assert(st1[0..3] == 3);
  assert(st1[2..$] == 7);
  st1[2] = 3;
  assert(st1[0..3] == 4);
  assert(st1[2..$] == 8);

  auto st2 = new SegmentTree!(int, min)(10, int.max);
  st2[0] = 8;
  st2[2] = 4;
  st2[5] = 5;
  assert(st2[0..0] == int.max);
  assert(st2[0..1] == 8);
  assert(st2[0..2] == 8);
  assert(st2[0..3] == 4);
  assert(st2[2..$] == 4);
  st2[2] = 9;
  assert(st2[0..3] == 8);
  assert(st2[2..$] == 5);

  auto st3 = new SegmentTree!(int)([1,2,3,4,5,6,7,8,9,10]);
  assert(st3[0..0] == 0);
  assert(st3[0..1] == 1);
  assert(st3[0..2] == 3);
  assert(st3[0..3] == 6);
  assert(st3[2..$] == 52);
}
