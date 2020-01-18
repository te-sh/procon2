class SegmentTree(alias pred = "a+b", T)
{
  import std.functional, std.math;
  alias predFun = binaryFun!pred;

  size_t n, an;
  T[] buf;
  T unit;

  @property auto data() { return buf[an..an+n]; }

  this(size_t n, T unit = T.init)
  {
    prepare(n, unit);
    if (T.init != unit) {
      buf[an..an+n][] = unit;
      propagateAll();
    }
  }

  this(T[] init, T unit = T.init)
  {
    prepare(init.length, unit);
    buf[an..an+n][] = init[];
    propagateAll();
  }

  auto prepare(size_t n, T unit)
  {
    this.n = n;
    this.unit = unit;
    an = (n-1).nextPow2;
    buf = new T[](an*2);
  }

  void opIndexAssign(T val, size_t i)
  {
    buf[i += an] = val;
    propagate(i);
  }

  void opIndexOpAssign(string op)(T val, size_t i)
  {
    mixin("buf[i += an]"~op~"=val;");
    propagate(i);
  }

  void opIndexUnary(string op)(size_t i) if (op=="++"||op=="--")
  {
    mixin(op~"buf[i += an];");
    propagate(i);
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

private:

  void propagateAll() { foreach_reverse (i; 1..an) buf[i] = predFun(buf[i*2], buf[i*2+1]); }
  void propagate(size_t i) { while (i /= 2) buf[i] = predFun(buf[i*2], buf[i*2+1]); }
}
SegmentTree!(pred, T) segmentTree(alias pred = "a+b", T)(size_t n, T unit = T.init)
{
  return new SegmentTree!(pred, T)(n, unit);
}
SegmentTree!(pred, T) segmentTree(alias pred = "a+b", T)(T[] init, T unit = T.init)
{
  return new SegmentTree!(pred, T)(init, unit);
}

/*

  class SegmentTree(alias pred = "a+b", T)

    Segment Tree を管理します.

    new SegmentTree!(pred, T)(size_t n, T unit = T.init)

      合成関数を pred とした大きさ n の Segment Tree を作成します.
      unit に合成時の初期値 unit を指定します. (デフォルト値は 0 です)

    new SegmentTree!(pred, T)(T[] init, T unit = T.init)

      合成関数を pred とした初期配列 init のセグメントツリーを作成します.
      unit に合成時の初期値 unit を指定します. (デフォルト値は 0 です)

    s[l..r]

      区間 [l, r) の合成値を返します.

    s[i]

      インデックス i の値を返します.

    s[i] = v

      インデックス i の値を v に変更します.

    s[i] += v
    s[i] -= v
    s[i] *= v
    s[i] /= v

      インデックス i の値と v とで四則演算を行います.

    ++s[i]
    --s[i]

      インデックス i の値を 1 増やし (減らし) ます.

  SegmentTree!(pred, T) segmentTree(alias pred = "a+b", T)(size_t n, T unit = T.init)

    合成関数を pred とした大きさ n の Segment Tree を作成します.
    unit に合成時の初期値 unit を指定します. (デフォルト値は 0 です)

  SegmentTree!(pred, T) segmentTree(alias pred = "a+b", T)(T[] init, T unit = T.init)

    合成関数を pred とした初期配列 init の Segment Tree を作成します.
    unit に合成時の初期値 unit を指定します. (デフォルト値は 0 です)

*/

unittest
{
  import std.algorithm, std.range;

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
