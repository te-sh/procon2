// URL: https://yukicoder.me/problems/no/177

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int W; io.getV(W);
  int N; io.getV(N);
  int[] J; io.getA(N, J);
  int M; io.getV(M);
  int[] C; io.getA(M, C);

  auto g = GraphW!int(N+M+2), s = N+M, t = N+M+1;
  foreach (i; 0..N) g.addEdge(s, i, J[i]);
  foreach (i; 0..M) g.addEdge(N+i, t, C[i]);

  foreach (i; 0..M) {
    int Q; io.getV(Q);
    int[] X; io.getA(Q, X); --X[];

    foreach (k; 0..N)
      if (!X.canFind(k))
        g.addEdge(k, N+i, g.inf);
  }

  io.putB(g.dinic(s, t).flow >= W, "SHIROBAKO", "BANSAKUTSUKITA");
}

import lib.graph.graph;

import lib.graph.dinic;

auto io = IO!()();
import lib.io;
