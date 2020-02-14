// URL: https://yukicoder.me/problems/no/179

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  string[] S; io.getC(H, S);

  auto a = grid(S.map!(l => l.map!(c => c == '.' ? 0 : 1).array).array);
  if (a.data.map!"a.sum".sum == 0) io.put!"{exit: true}"("NO");

  foreach (y; 0..H) {
  loop: foreach (x; -W+1..W) {
      auto b = a.dup, d = b.pos(y, x);
      foreach (p; b.walk)
        if (b[p] == 1) {
          b[p] = 2;
          auto q = p+d;
          if (!q.inGrid || b[q] != 1) continue loop;
          b[q] = 3;
        }
      io.put!"{exit: true}"("YES");
    }
  }

  io.put("NO");
}

import lib.data_structure.grid;

auto io = IO!()();
import lib.io;
