// URL: https://yukicoder.me/problems/no/763

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto g = Graph(N);
  foreach (_; 0..N-1) {
    int U, V; io.getV(U, V); --U; --V;
    g.addEdgeB(U, V);
  }
  auto t = g.tree(0);

  auto a = new int[](N), b = new int[](N);
  foreach_reverse (u; t.dfsOrder) {
    a[u] = 1;
    foreach (v; t.children(u)) {
      a[u] += max(a[v]-1, b[v]);
      b[u] += max(a[v], b[v]);
    }
  }

  io.put(max(a[0], b[0]));
}

import lib.graph.graph;

import lib.graph.tree;

auto io = IO!()();
import lib.io;
