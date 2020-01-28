// URL: https://yukicoder.me/problems/no/707

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  string[] P; io.getC(H, P);

  auto r = 1.0e+10L;

  auto calc(int x, int y)
  {
    auto s = 0.0L;
    foreach (i; 0..H)
      foreach (j; 0..W)
        if (P[i][j] == '1')
          s += ((i+1-y)^^2+(j+1-x)^^2).to!double.sqrt;

    r = min(r, s);
  }

  foreach (i; 1..H+1) {
    calc(0, i);
    calc(W+1, i);
  }

  foreach (i; 1..W+1) {
    calc(i, 0);
    calc(i, H+1);
  }

  io.put(r);
}

auto io = IO!()();
import lib.io;
