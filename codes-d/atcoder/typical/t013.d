// URL: https://atcoder.jp/contests/typical90/tasks/typical90_m

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  auto g = GraphW!(long, 10L^^18)(N);

  foreach (_; 0..M) {
    int Ai, Bi, Ci; io.getV(Ai, Bi, Ci);
    g.addEdgeB(Ai-1, Bi-1, Ci);
  }

  auto S = g.dijkstra(0).dist, T = g.dijkstra(N-1).dist;
  foreach (i; 0..N) io.put(S[i]+T[i]);
}

import lib.graph.graph;
import lib.graph.dijkstra;

auto io = IO!()();
import lib.io;
