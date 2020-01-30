// URL: https://yukicoder.me/problems/no/743

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  struct E { int a, b; }
  E[] e; io.getS!("a", "b")(N, e);

  foreach (ref ei; e)
    if (ei.a > ei.b) swap(ei.a, ei.b);

  e.sort!"a.a < b.a";

  auto ft = fenwickTree!int(M), r = 0L;
  foreach (ei; e) {
    r += ft[ei.a..ei.b];
    ++ft[ei.b];
  }

  io.put(r);
}

import lib.data_structure.fenwick_tree;

auto io = IO!()();
import lib.io;
