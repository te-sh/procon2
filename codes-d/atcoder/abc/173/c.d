// URL: https://atcoder.jp/contests/abc173/tasks/abc173_c

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int H, W, K; io.getV(H, W, K);
  string[] c; io.getC(H, c);

  auto r = 0;
  foreach (p; 0..1<<H)
    foreach (q; 0..1<<W) {
      auto n = 0;
      foreach (i; 0..H)
        foreach (j; 0..W)
          if (!p.bitTest(i) && !q.bitTest(j) && c[i][j] == '#')
            ++n;
      if (n == K) ++r;
    }

  io.put(r);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
