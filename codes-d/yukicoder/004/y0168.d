// URL: https://yukicoder.me/problems/no/168

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  alias Point = Point2!long;
  Point[] p; io.getS!("x", "y")(N, p);

  struct D { int s, t; long d; }
  D[] d;
  foreach (i; 0..N)
    foreach (j; i+1..N)
      d ~= D(i, j, (p[i]-p[j]).hypot2);

  d.sort!"a.d<b.d";

  auto uf = new UnionFind(N);
  foreach (di; d) {
    uf.unite(di.s, di.t);
    if (uf.isSame(0, N-1)) {
      auto bs = iota(10, cast(long)int.max, 10)
        .map!(l => tuple(l, di.d <= l^^2))
        .assumeSorted!"a[1]<b[1]";
      io.put(bs.upperBound(tuple(0, false)).front[0]);
      return;
    }
  }
}

import lib.math.point;

import lib.data_structure.union_find;

auto io = IO!()();
import lib.io;
