module lib.data_structure.segment_tree_lazy;
import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

class SegmentTreeLazy(T, Op, Op opNone)
{
  struct Section { T val, laz; Op op; }
  const size_t n, an;
  Section[] sec;
  T unit;

  this(size_t n, T unit = T.init)
  {
    this.n = n;
    this.unit = unit;
    an = (n-1).nextPow2;
    sec = new Section[](an*2);
    if (T.init != unit)
      foreach (ref seci; sec) seci.val = unit;
  }

  abstract T compose(T a, T b);
  abstract void updateSection(ref Section sec, Op op, T val, size_t s);

  void propagate(size_t k, size_t nl, size_t nr)
  {
    if (sec[k].op == opNone) return;

    size_t nm = (nl+nr)/2;
    updateSection(sec[k*2],   sec[k].op, sec[k].laz, nm-nl);
    updateSection(sec[k*2+1], sec[k].op, sec[k].laz, nr-nm);

    sec[k].op = opNone;
  }

  void apply(Op op, T val, size_t l, size_t r) { apply(op, val, l, r, 1, 0, an); }
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

  T summary(size_t l, size_t r, size_t k, size_t nl, size_t nr)
  {
    if (nr <= l || r <= nl) return unit;
    if (l <= nl && nr <= r) return sec[k].val;

    propagate(k, nl, nr);

    auto nm = (nl+nr)/2;
    auto vl = summary(l, r, k*2,   nl, nm);
    auto vr = summary(l, r, k*2+1, nm, nr);

    return compose(vl, vr);
  }

  T opSlice(size_t l, size_t r) { return summary(l, r, 1, 0, an); }
  pure size_t opDollar() { return n; }
}

unittest
{
  enum Op { none, fill, add }
  class SegTree(T) : SegmentTreeLazy!(T, Op, Op.none)
  {
    this(size_t n, T unit = T.init) { super(n, unit); }
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
