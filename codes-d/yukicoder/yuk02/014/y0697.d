// URL: https://yukicoder.me/problems/no/697

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.bitmanip;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  auto n = (H+2)*(W+2);

  auto b = BitArray();
  b.length = n;

  foreach (r; 0..H) {
    int[] A; io.getA(W, A);
    foreach (c; 0..W)
      if (A[c]) b[(r+1)*(W+2)+c+1] = true;
  }

  auto v = BitArray();
  v.length = n;

  auto p = 0;
  foreach (i; 0..n) {
    if (b[i] && !v[i]) {
      ++p;
      auto q = DList!int(i);
      v[i] = true;
      while (!q.empty) {
        auto d = q.front; q.removeFront();
        foreach (e; [d-1, d+1, d-(W+2), d+(W+2)]) {
          if (b[e] && !v[e]) {
            v[e] = true;
            q.insertBack(e);
          }
        }
      }
    }
  }

  io.put(p);
}

auto io = IO!()();
import lib.io;
