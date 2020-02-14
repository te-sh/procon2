// URL: https://yukicoder.me/problems/no/13

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int W, H; io.getV(W, H);
  int[][] M; io.getM(H, W, M);

  auto g = grid(M), v = g.grid!bool;
  alias Pos = g.Pos;

  auto hasCycle(Pos p)
  {
    struct Pos2 { Pos curr, prev; }
    auto q = DList!Pos2(Pos2(p, p)); v[p] = true;

    while (!q.empty) {
      auto e = q.front; q.removeFront();
      foreach (d; e.curr.around4.filter!(d => d != e.prev && g[d] == g[p])) {
	if (v[d]) return true;
	q.insertBack(Pos2(d, e.curr)); v[d] = true;
      }
    }

    return false;
  }

  foreach (p; g.walk)
    if (!v[p] && hasCycle(p)) io.put!"{exit: true}"("possible");

  io.put("impossible");
}

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
