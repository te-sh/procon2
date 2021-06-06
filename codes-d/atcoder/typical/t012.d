// URL: https://atcoder.jp/contests/typical90/tasks/typical90_l

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);

  auto b = new bool[][](H+2, W+2);
  auto uf = unionFind((H+2)*(W+2));

  int Q; io.getV(Q);
  foreach (_; 0..Q) {
    int t; io.getV(t);
    switch (t) {
    case 1:
      int r, c; io.getV(r, c);
      b[r][c] = true;
      if (b[r-1][c]) uf.unite(r*(W+2)+c, (r-1)*(W+2)+c);
      if (b[r+1][c]) uf.unite(r*(W+2)+c, (r+1)*(W+2)+c);
      if (b[r][c-1]) uf.unite(r*(W+2)+c, r*(W+2)+(c-1));
      if (b[r][c+1]) uf.unite(r*(W+2)+c, r*(W+2)+(c+1));
      break;
    case 2:
      int r1, c1, r2, c2; io.getV(r1, c1, r2, c2);
      io.putB(b[r1][c1] && b[r2][c2] && uf.isSame(r1*(W+2)+c1, r2*(W+2)+c2), "Yes", "No");
      break;
    default:
      assert(0);
    }
  }
}

import lib.data_structure.union_find;

auto io = IO!()();
import lib.io;
