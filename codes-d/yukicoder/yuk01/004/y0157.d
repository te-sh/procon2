// URL: https://yukicoder.me/problems/no/157

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int W, H; io.getV(W, H);
  string[] C; io.getC(H, C);

  alias rg = Region!(H, W), Pos = rg.Pos;
  auto c = rg.grid(cast(char[][])C), b = rg.grid!bool;

  auto findSpace()
  {
    foreach (p; rg.allPos)
      if (c[p] == '.' && !b[p]) {
        auto r = [p];
        b[p] = true;
        auto q = DList!(Pos)(p);
        while (!q.empty) {
          auto u = q.front; q.removeFront();
          foreach (v; u.around4) {
            if (c[v] == '.' && !b[v]) {
              r ~= v;
              b[v] = true;
              q.insertBack(v);
            }
          }
        }
        return r;
      }
    assert(0);
  }

  auto distManhattan(Pos p1, Pos p2) { return abs(p1.r-p2.r)+abs(p1.c-p2.c); }

  auto s1 = findSpace(), s2 = findSpace(), r = 1000;
  foreach (p1; s1)
    foreach (p2; s2)
      r = min(r, distManhattan(p1, p2));

  io.put(r-1);
}

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
