// URL: https://atcoder.jp/contests/typical90/tasks/typical90_ac

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int W, N; io.getV(W, N);

  auto s = new SegTree!int(W+1);

  foreach (_; 0..N) {
    int Li, Ri; io.getV(Li, Ri); Ri++;
    auto t = s[Li..Ri] + 1;
    io.put(t);
    s[Li..Ri] = t;
  }
}

enum Op { none, fill, add }
class SegTree(T) : SegmentTreeLazy!(T, Op, Op.none)
{
  this(size_t n, T dflt = T.init) { super(n, dflt); }
  void opSliceAssign(T val, size_t l, size_t r) { apply(Op.fill, val, l, r); }

  override T compose(T a, T b) { return max(a, b); }
  override void updateSection(ref Section sec, Op op, T val, size_t s)
  {
    switch (op) {
    case Op.fill:
      sec.val = val;
      sec.laz = val;
      sec.op = Op.fill;
      break;
    default:
      assert(0);
    }
  }
}

import lib.data_structure.segment_tree_lazy;

auto io = IO!()();
import lib.io;
