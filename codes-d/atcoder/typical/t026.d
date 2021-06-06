// URL: https://atcoder.jp/contests/typical90/tasks/typical90_z

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto g = Graph(N);
  foreach (_; 0..N-1) {
    int Ai, Bi; io.getV(Ai, Bi);
    g.addEdgeB(Ai-1, Bi-1);
  }
  auto t = g.tree(0);

  auto s = 0;
  foreach (i; 0..N)
    if (t.depth[i]%2 == 0) ++s;

  auto r = new int[](N/2), c = 0;
  foreach (i; 0..N) {
    if (t.depth[i]%2 == (s >= N/2 ? 0 : 1)) {
      r[c++] = i+1;
      if (c >= N/2) break;
    }
  }

  io.put(r);
}

import lib.graph.graph;
import lib.graph.tree;

auto io = IO!()();
import lib.io;
