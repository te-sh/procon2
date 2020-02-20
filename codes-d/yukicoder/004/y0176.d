// URL: https://yukicoder.me/problems/no/176

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int A, B, T; io.getV(A, B, T);

  auto r = int.max;
  foreach (y; 0..min(A, cdiv(T, B))+1) {
    auto s = T-B*y;
    if (s == 0)
      r = min(r, B*y);
    else
      r = min(r, B*y + cdiv(s, A)*A);
  }

  io.put(r);
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
