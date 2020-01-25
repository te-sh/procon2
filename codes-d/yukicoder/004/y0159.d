// URL: https://yukicoder.me/problems/no/159

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  double p, q; io.getV(p, q);
  io.putB(1-p < p*(1-q), "YES", "NO");
}

auto io = IO!()();
import lib.io;
