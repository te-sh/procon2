// URL: https://yukicoder.me/problems/no/34

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, V, Sx, Sy, Gx, Gy; io.getV(N, V, Sx, Sy, Gx, Gy); --Sx; --Sy; --Gx; --Gy;
  int[][] L; io.getM(N, N, L);

  alias rg = Region!(N, N), Pos = rg.Pos;
  auto m = rg.grid(L);
  auto S = Pos(Sy, Sx), G = Pos(Gy, Gx);

  auto v = rg.grid!int, inf = 10^^6;
  foreach (p; rg.allPos) v[p] = inf;
  v[S] = 0;

  struct E { Pos p; int d, h; }
  auto q = DList!E(E(S, 0, 0));
  while (!q.empty) {
    auto e = q.front; q.removeFront();
    foreach (np; e.p.around4) {
      auto nh = e.h+m[np];
      if (nh >= V) continue;
      if (np == G) io.put!"{exit: true}"(e.d+1);
      if (nh < v[np]) {
        v[np] = nh;
        q.insertBack(E(np, e.d+1, nh));
      }
    }
  }
  io.put(-1);
}

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
