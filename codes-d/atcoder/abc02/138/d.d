// URL: https://atcoder.jp/contests/abc138/tasks/abc138_d

import std;

version(unittest) {} else
void main()
{
  int N, Q; io.getV(N, Q);

  auto g = Graph(N);
  foreach (_; 0..N-1) {
    int ai, bi; io.getV(ai, bi); --ai; --bi;
    g.addEdgeB(ai, bi);
  }
  auto t = g.tree(0);

  auto c = new int[](N);
  foreach (_; 0..Q) {
    int pi, xi; io.getV(pi, xi); --pi;
    c[pi] += xi;
  }

  auto s = SList!int(0);
  while (!s.empty) {
    auto u = s.front; s.removeFront();
    if (u != 0) c[u] += c[t.parent[u]];
    foreach (v; t.children(u))
      s.insertFront(v);
  }

  io.put(c);
}

import lib.graph.graph;
import lib.graph.tree;

auto io = IO!()();
import lib.io;
