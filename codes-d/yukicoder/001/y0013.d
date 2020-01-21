// URL: https://yukicoder.me/problems/no/13

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int W, H; io.getV(W, H);
  int[][] M; io.getM(H, W, M);

  auto g = grid(M), v = Grid!bool(W, H);
  alias P = g.P;

  auto hasCycle(P p)
  {
    struct P2 { P curr, prev; }
    auto q = DList!P2(P2(p, p)); v[p] = true;

    while (!q.empty) {
      auto e = q.front; q.removeFront();
      foreach (d; g.around4(e.curr).filter!(d => d != e.prev && g[d] == g[p])) {
	if (v[d]) return true;
	q.insertBack(P2(d, e.curr)); v[d] = true;
      }
    }

    return false;
  }

  foreach (y; 0..H)
    foreach (x; 0..W)
      if (!v[x, y] && hasCycle(P(x, y))) {
	io.put("possible");
	return;
      }

  io.put("impossible");
}

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
