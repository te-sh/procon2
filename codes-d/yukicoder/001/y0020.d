// URL: https://yukicoder.me/problems/no/20

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, V, Ox, Oy; io.getV(N, V, Ox, Oy); --Ox; --Oy;
  int[][] L; io.getM(N, N, L);

  alias rg = Region!(N, N), Pos = rg.Pos;
  auto a = rg.grid(L), g = GraphW!int(N*N);
  foreach (p; rg.allPos)
    foreach (np; p.around4)
      g.addEdge(p.p2i, np.p2i, a[np]);

  auto d1 = g.dijkstra(Pos(0, 0).p2i).dist;
  if (V - d1[Pos(N-1, N-1).p2i] > 0) io.put!"{exit: true}"("YES");

  if (Ox >= 0 && Oy >= 0) {
    auto d2 = g.dijkstra(Pos(Oy, Ox).p2i).dist;
    if ((V - d1[Pos(Oy, Ox).p2i])*2 - d2[Pos(N-1, N-1).p2i] > 0) io.put!"{exit: true}"("YES");
  }

  io.put("NO");
}

import lib.data_structure.grid;

import lib.graph.graph;

import lib.graph.dijkstra;

auto io = IO!()();
import lib.io;
