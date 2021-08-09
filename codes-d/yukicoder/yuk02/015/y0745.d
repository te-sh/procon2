// URL: https://yukicoder.me/problems/no/745

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int A, B, C, D; io.getV(A, B, C, D);

  io.putB(D < 10, "Possible", "Impossible");
  if (D >= 10) return;

  auto e = 0, s = 0;
  foreach (i; 0..B) {
    ++e;
    s += 50 * 2^^((e-1)/100);
  }
  foreach (i; 0..A) {
    ++e;
    s += 100 * 2^^((e-1)/100);
  }

  io.put(s);
}

auto io = IO!()();
import lib.io;
