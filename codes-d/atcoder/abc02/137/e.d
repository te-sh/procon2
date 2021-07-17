// URL: https://atcoder.jp/contests/abc137/tasks/abc137_e

import std;

version(unittest) {} else
void main()
{
  int N, M, P; io.getV(N, M, P);

  auto g = GraphW!int(N);
  foreach (_; 0..M) {
    int Ai, Bi, Ci; io.getV(Ai, Bi, Ci); --Ai; --Bi;
    g.addEdge(Ai, Bi, P-Ci);
  }

  auto d = g.bellmanFord(0).dist[N-1];
  io.putB(d <= -g.inf, -1, max(-d, 0));
}

import lib.graph.graph;
import lib.graph.bellman_ford;

auto io = IO!()();
import lib.io;
