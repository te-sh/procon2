// URL: https://yukicoder.me/problems/no/629

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  int[] a; io.getA(N, a);

  auto g = Graph(N);
  foreach (_; 0..M) {
    int u, v; io.getV(u, v); --u; --v;
    g.addEdgeB(u, v);
  }

  foreach (i; 0..N) {
    auto b = a.indexed(g[i]);
    auto v1 = b.filter!(bi => bi > a[i]).array;
    auto v2 = b.filter!(bi => bi < a[i]).array;
    if (v1.sort.uniq.walkLength >= 2 || v2.sort.uniq.walkLength >= 2)
      io.put!"{exit: true}"("YES");
  }

  io.put("NO");
}

import lib.graph.graph;

auto io = IO!()();
import lib.io;
