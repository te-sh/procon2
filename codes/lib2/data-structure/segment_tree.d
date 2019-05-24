class SegmentTree(T, alias pred = "a+b")
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

  auto opIndexAssign(T val, size_t i)
  {
    buf[i += an] = val;
    propagate(i);
  }

  auto opIndexOpAssign(string op)(T val, size_t i)
  {
    mixin("buf[i += an]"~op~"=val;");
    propagate(i);
  }

  auto opIndexUnary(string op)(size_t i) if (op == "++" || op == "--")
  {
    mixin(op~"buf[i += an];");
    propagate(i);
  }

  pure auto opSlice(size_t l, size_t r)
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

  pure auto opIndex(size_t i) { return buf[i+an]; }
  pure auto opDollar() { return n; }

private:

  auto propagateAll() { foreach_reverse (i; 1..an) buf[i] = predFun(buf[i*2], buf[i*2+1]); }
  auto propagate(size_t i) { while (i /= 2) buf[i] = predFun(buf[i*2], buf[i*2+1]); }
}

/*

  SegmentTree!(T, pred)

    セグメントツリーを表すクラスです.

  new SegmentTree!(T, pred)(n, unit)

    合成関数を pred とした大きさ n のセグメントツリーを作成します.
    合成時の初期値 unit を指定できます. (デフォルト値は 0)

  new SegmentTree!(T, pred)(a, unit)

    合成関数を pred とした初期配列 a のセグメントツリーを作成します.
    合成時の初期値 unit を指定できます. (デフォルト値は 0)

  st[l..r]

    区間 [l, r) の合成値を返します.

  st[i]

    インデックス i の値を返します.

  st[i] = v

    インデックス i の値を v に変更します.

  st[i] += v

    インデックス i の値を v 増やします.
    他の演算子も使えます.

  ++st[i]

    インデックス i の値を1増やします.
    -- 演算子も使えます.

 */

unittest
{
  import std.algorithm;

  auto st1 = new SegmentTree!(int, "a+b")(6);
  st1[0] = 1;
  st1[2] = 2;
  st1[5] = 5;
  assert(st1[0] == 1);
  assert(st1[2] == 2);
  assert(st1[5] == 5);
  assert(st1.data == [1, 0, 2, 0, 0, 5]);
  assert(st1[0..0] == 0);
  assert(st1[0..1] == 1);
  assert(st1[0..2] == 1);
  assert(st1[0..3] == 3);
  assert(st1[2..$] == 7);
  ++st1[2];
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
  st2[2] += 5;
  assert(st2[0..3] == 8);
  assert(st2[2..$] == 5);

  auto st3 = new SegmentTree!int([1,2,3,4,5,6,7,8,9,10]);
  assert(st3[0..0] == 0);
  assert(st3[0..1] == 1);
  assert(st3[0..2] == 3);
  assert(st3[0..3] == 6);
  assert(st3[2..$] == 52);
}
