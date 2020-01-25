// URL: https://yukicoder.me/problems/no/34

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, V, Sx, Sy, Gx, Gy; io.getV(N, V, Sx, Sy, Gx, Gy); --Sx; --Sy; --Gx; --Gy;
  int[][] L; io.getM(N, N, L);

  auto m = grid(L);
  alias Point = m.Point;
  auto S = Point(Sx, Sy), G = Point(Gx, Gy);

  auto v = Grid!int(N, N), inf = 10^^6;
  foreach (x; 0..N) foreach (y; 0..N) v[x, y] = inf;
  v[S] = 0;

  struct E { Point p; int d, h; }
  auto q = DList!E(E(S, 0, 0));
  while (!q.empty) {
    auto e = q.front; q.removeFront();
    foreach (np; m.around4(e.p)) {
      auto nh = e.h+m[np];
      if (nh >= V) continue;
      if (np == G) {
        io.put(e.d+1);
        return;
      }
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
