// URL: https://yukicoder.me/problems/no/734

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long A, B, C; io.getV(A, B, C);
  auto d = A*60-B;
  io.putB(d <= 0, -1, (C*3600+d-1)/d);
}

auto io = IO!()();
import lib.io;
