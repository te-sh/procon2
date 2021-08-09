// URL: https://yukicoder.me/problems/no/1

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int C; io.getV(C);
  int V; io.getV(V);
  int[] S; io.getA(V, S); --S[];
  int[] T; io.getA(V, T); --T[];
  int[] Y; io.getA(V, Y);
  int[] M; io.getA(V, M);

  auto g = GraphW!int(N*(C+1));
  foreach (Si, Ti, Yi, Mi; lockstep(S, T, Y, M))
    foreach (c; 0..C-Yi+1)
      g.addEdge((C+1)*Si+c, (C+1)*Ti+c+Yi, Mi);

  auto r = g.dijkstra(0).dist[(N-1)*(C+1)..N*(C+1)].minElement;
  io.putB(r < g.inf, r, -1);
}

import lib.graph.graph;

import lib.graph.dijkstra;

auto io = IO!()();
import lib.io;
