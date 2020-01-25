// URL: https://yukicoder.me/problems/no/176

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int A, B, T; io.getV(A, B, T);

  auto r = int.max;
  foreach (y; 0..min(A, (T+B-1)/B)+1) {
    auto s = T-B*y;
    if (s == 0)
      r = min(r, B*y);
    else
      r = min(r, B*y + (s+A-1)/A*A);
  }

  io.put(r);
}

auto io = IO!()();
import lib.io;
