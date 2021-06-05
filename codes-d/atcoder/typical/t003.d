// URL: https://atcoder.jp/contests/typical90/tasks/typical90_c

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto g = Graph(N);
  foreach (i; 0..N-1) {
    int Ai, Bi; io.getV(Ai, Bi);
    g.addEdgeB(Ai-1, Bi-1);
  }

  auto d1 = new int[](N); d1[] = -1; d1[0] = 0;
  auto q1 = DList!int(0);
  while (!q1.empty) {
    auto u = q1.front; q1.removeFront();
    foreach (v; g[u]) {
      if (d1[v] == -1) {
        d1[v] = d1[u]+1;
        q1.insertBack(v);
      }
    }
  }

  auto c = d1.maxIndex.to!int;
  auto d2 = new int[](N); d2[] = -1; d2[c] = 0;
  auto q2 = DList!int(c);
  while (!q2.empty) {
    auto u = q2.front; q2.removeFront();
    foreach (v; g[u]) {
      if (d2[v] == -1) {
        d2[v] = d2[u]+1;
        q2.insertBack(v);
      }
    }
  }

  io.put(d2.maxElement+1);
}

import lib.graph.graph;

auto io = IO!()();
import lib.io;
