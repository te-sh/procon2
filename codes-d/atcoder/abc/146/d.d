// URL: https://atcoder.jp/contests/abc146/tasks/abc146_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a, b; io.getC(N-1, a, b); a[] -= 1; b[] -= 1;

  auto g = Graph(N), c = new int[int][](N);
  foreach (ai, bi; lockstep(a, b)) {
    g.addEdgeB(ai, bi);
    c[ai][bi] = c[bi][ai] = 0;
  }
  auto t = g.tree(0);

  auto q = DList!int(0);
  while (!q.empty) {
    auto u = q.front; q.removeFront();
    auto cc = 1;
    foreach (v; t.children(u)) {
      if (u != 0 && cc == c[u][t.parent[u]]) ++cc;
      c[u][v] = c[v][u] = cc;
      ++cc;
      q.insertBack(v);
    }
  }

  io.put(c.map!(ci => ci.values()).joiner.maxElement);
  foreach (ai, bi; lockstep(a, b))
    io.put(c[ai][bi]);
}

import lib.graph.graph;
import lib.graph.tree;

auto io = IO!()();
import lib.io;
