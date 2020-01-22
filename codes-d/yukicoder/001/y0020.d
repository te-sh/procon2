// URL: https://yukicoder.me/problems/no/20

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, V, Ox, Oy; io.getV(N, V, Ox, Oy); --Ox; --Oy;
  int[][] L; io.getM(N, N, L);

  auto a = grid(L);
  alias P = a.P;

  auto g = GraphW!int(N*N);
  foreach (y; 0..N)
    foreach (x; 0..N) {
      auto p = P(x, y);
      foreach (np; a.around4(p))
	g.addEdge(cast(int)a.p2i(p), cast(int)a.p2i(np), a[np]);
    }

  auto d1 = g.dijkstra(cast(int)a.p2i(P(0, 0))).dist;
  if (V - d1[a.p2i(P(N-1, N-1))] > 0) {
    io.put("YES");
    return;
  }

  if (Ox >= 0 && Oy >= 0) {
    auto d2 = g.dijkstra(cast(int)a.p2i(P(Ox, Oy))).dist;
    if ((V - d1[a.p2i(P(Ox, Oy))])*2 - d2[a.p2i(P(N-1, N-1))] > 0) {
      io.put("YES");
      return;
    }
  }

  io.put("NO");
}

import lib.data_structure.grid;

import lib.graph.graph;

import lib.graph.dijkstra;

auto io = IO!()();
import lib.io;
