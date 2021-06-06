module lib.data_structure.segment_tree_lazy;
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

// :::::::::::::::::::: lib.data_structure.segment_tree_lazy
/**
 ** 遅延伝播 Segment Tree を表します.
 ** このクラスは継承されて使われることを想定しています.
 ** opNone は操作がない Op 型です.
 **/
class SegmentTreeLazy(T, Op, Op opNone)
{
  /**
   ** 要素数です.
   **/
  const size_t n;

  pure nothrow @safe
  {
    /**
     ** 要素数 n の遅延伝播 Segment Tree を返します.
     ** dflt は値がない要素のデフォルト値です.
     **/
    this(size_t n, T dflt = T.init)
    {
      this.n = n;
      this.dflt = dflt;
      an = n == 1 ? 1 : (n-1).nextPow2;
      sec = new Section[](an*2);
      if (T.init != dflt)
        foreach (ref seci; sec) seci.val = dflt;
    }
  }

  /**
   ** 区間 [l, r) に演算 op を値 val に適用します.
   ** 外部からこの関数を直接呼び出すか, このクラスを継承したクラスに扱いやすいような関数を
   ** 定義してこの関数を呼び出すかで使用することになるでしょう.
   **/
  void apply(Op op, T val, size_t l, size_t r)
    in { assert(0 <= l && l <= r && r <= n); }
  do
  {
    apply(op, val, l, r, 1, 0, an);
  }

  /**
   ** 区間 [l, r) の合成値を返します.
   **/
  T opSlice(size_t l, size_t r)
    in { assert(0 <= l && l <= r && r <= n); }
  do
  {
    return summary(l, r, 1, 0, an);
  }

  pure nothrow @nogc @safe
  {
    /**
     ** 要素数を返します.
     **/
    size_t opDollar()
    {
      return n;
    }
  }

  protected
  {
    /**
     ** セクション情報を表す構造体です.
     ** val はこのセクションが持ってる値です.
     ** laz は子セクションの伝播に使う値です.
     ** op は子セクションの伝播に使う演算です.
     **/
    struct Section { T val, laz; Op op; }
    /**
     ** セクションごとのセクション情報の配列です.
     **/
    Section[] sec;
    /**
     ** 要素の合成に使う関数です.
     ** このクラスを継承したクラスで定義します.
     **/
    abstract T compose(T a, T b);
    /**
     ** セクション情報を更新する関数です.
     ** op, val を使って自セクションの情報を更新します.
     ** このクラスを継承したクラスで定義します.
     **/
    abstract void updateSection(ref Section sec, Op op, T val, size_t s);
  }

  private
  {
    const size_t an;
    T dflt;

    T summary(size_t l, size_t r, size_t k, size_t nl, size_t nr)
    {
      if (nr <= l || r <= nl) return dflt;
      if (l <= nl && nr <= r) return sec[k].val;

      propagate(k, nl, nr);

      auto nm = (nl+nr)/2;
      auto vl = summary(l, r, k*2,   nl, nm);
      auto vr = summary(l, r, k*2+1, nm, nr);

      return compose(vl, vr);
    }

    void propagate(size_t k, size_t nl, size_t nr)
    {
      if (sec[k].op == opNone) return;

      size_t nm = (nl+nr)/2;
      updateSection(sec[k*2],   sec[k].op, sec[k].laz, nm-nl);
      updateSection(sec[k*2+1], sec[k].op, sec[k].laz, nr-nm);

      sec[k].op = opNone;
    }

    void apply(Op op, T val, size_t l, size_t r, size_t k, size_t nl, size_t nr)
    {
      if (nr <= l || r <= nl) return;

      if (l <= nl && nr <= r) {
        updateSection(sec[k], op, val, nr-nl);
        return;
      }

      propagate(k, nl, nr);

      auto nm = (nl+nr)/2;
      apply(op, val, l, r, k*2,   nl, nm);
      apply(op, val, l, r, k*2+1, nm, nr);

      sec[k].val = compose(sec[k*2].val, sec[k*2+1].val);
    }
  }
}
// ::::::::::::::::::::

unittest
{
  enum Op { none, fill, add }
  class SegTree(T) : SegmentTreeLazy!(T, Op, Op.none)
  {
    this(size_t n, T dflt = T.init) { super(n, dflt); }
    void opSliceAssign(T val, size_t l, size_t r) { apply(Op.fill, val, l, r); }
    void opSliceOpAssign(string op: "+")(T val, size_t l, size_t r) { apply(Op.add, val, l, r); }

    override T compose(T a, T b) { return a+b; }
    override void updateSection(ref Section sec, Op op, T val, size_t s)
    {
      switch (op) {
      case Op.fill:
        sec.val = val * cast(T)s;
        sec.laz = val;
        sec.op = Op.fill;
        break;
      case Op.add:
        sec.val += val * cast(T)s;
        sec.laz = sec.op == Op.none ? val : sec.laz + val;
        sec.op = sec.op == Op.fill ? Op.fill : Op.add;
        break;
      default:
        assert(0);
      }
    }
  }

  auto st1 = new SegTree!int(7);
  st1[0..5] = 1;
  st1[2..7] = 2;
  assert(st1[0..0] == 0);
  assert(st1[0..1] == 1);
  assert(st1[0..2] == 2);
  assert(st1[0..3] == 4);
  assert(st1[2..$] == 10);
  st1[3..6] += 3;
  assert(st1[0..3] == 4);
  assert(st1[2..$] == 19);
}
