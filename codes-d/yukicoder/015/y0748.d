// URL: https://yukicoder.me/problems/no/748

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M, K; io.getV(N, M, K);
  struct R { int a, b, c, i; }
  R[] r; io.getS!("a", "b", "c")(M, r);
  foreach (i, ref ri; r) { --ri.a; --ri.b; ri.i = cast(int)i; }
  int[] e; io.getC(K, e); --e[];

  auto v = new bool[](M), uf = unionFind(N);

  foreach (ei; e) {
    uf.unite(r[ei].a, r[ei].b);
    v[ei] = true;
  }

  auto r2 = r.dup.sort!"a.c<b.c";
  foreach (ri; r2)
    if (!v[ri.i] && !uf.isSame(ri.a, ri.b)) {
      uf.unite(ri.a, ri.b);
      v[ri.i] = true;
    }

  auto s = 0L;
  foreach (i; 0..M) if (!v[i]) s += r[i].c;

  io.put(s);
}

import lib.data_structure.union_find;

auto io = IO!()();
import lib.io;
