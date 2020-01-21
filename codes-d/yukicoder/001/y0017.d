// URL: https://yukicoder.me/problems/no/17

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] S; io.getC(N, S);

  auto g = GraphM!int.init(N);

  int M; io.getV(M);
  foreach (_; 0..M) {
    int A, B, C; io.getV(A, B, C);
    g[A][B] = g[B][A] = C;
  }
  auto dist = g.floydWarshal.dist;

  auto r = g.inf;
  foreach (i; 1..N-1)
    foreach (j; 1..N-1)
      if (i != j && dist[0][i] < g.inf && dist[i][j] < g.inf && dist[j][N-1] < g.inf)
        r = min(r, dist[0][i] + S[i] + dist[i][j] + S[j] + dist[j][N-1]);
  io.put(r);
}

import lib.graph.graph;

import lib.graph.floyd_warshal;

auto io = IO!()();
import lib.io;
