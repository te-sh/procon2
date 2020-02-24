// URL: https://yukicoder.me/problems/no/168

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
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
      io.put(iota(10, cast(long)int.max, 10).upperBoundBy!(l => di.d <= l^^2)(false).front);
      return;
    }
  }
}

import lib.bound_by;

alias Point = Point2!long;
import lib.math.point;

import lib.data_structure.union_find;

auto io = IO!()();
import lib.io;
