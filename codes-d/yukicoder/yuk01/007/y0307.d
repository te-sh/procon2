// URL: https://yukicoder.me/problems/no/307

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  int[][] A; io.getM(H, W, A);

  alias rg = Region!(H, W), Pos = rg.Pos;
  auto g = rg.grid(A);

  int Q; io.getV(Q);
  auto isWhole = false, wholeColor = 0;
  foreach (_; 0..Q) {
    int R, C, X; io.getV(R, C, X); --R; --C;
    if (isWhole) {
      wholeColor = X;
    } else {
      if (g[R, C] == X) continue;

      auto c = 1, q = DList!Pos(Pos(R, C));
      g[R, C] = X;
      while (!q.empty) {
        auto p = q.front; q.removeFront();
        foreach (np; p.around4) {
          if (g[np] != X) {
            ++c;
            g[np] = X;
            q.insertBack(np);
          }
        }
      }

      if (c == H*W) {
        isWhole = true;
        wholeColor = X;
      }
    }
  }

  if (isWhole) {
    foreach (_; 0..H)
      io.put(wholeColor.repeat.take(W));
  } else {
    foreach (i; 0..H)
      io.put(g.data[i]);
  }
}

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
