// URL: https://yukicoder.me/problems/no/157

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int W, H; io.getV(W, H);
  string[] C; io.getC(H, C);

  auto c = grid(cast(char[][])C), b = c.grid!bool;

  auto findSpace()
  {
    foreach (p; c.walk)
      if (c[p] == '.' && !b[p]) {
        auto r = [p];
        b[p] = true;
        auto q = DList!(c.Pos)(p);
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

  auto distManhattan(c.Pos p1, c.Pos p2) { return abs(p1.r-p2.r)+abs(p1.c-p2.c); }

  auto s1 = findSpace(), s2 = findSpace(), r = 1000;
  foreach (p1; s1)
    foreach (p2; s2)
      r = min(r, distManhattan(p1, p2));

  io.put(r-1);
}

import lib.math.point;

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
