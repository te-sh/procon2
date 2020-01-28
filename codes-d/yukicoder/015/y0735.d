// URL: https://yukicoder.me/problems/no/735

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  double r, d; io.getV(r, d);
  io.put((d^^2-r^^2).sqrt);
}

auto io = IO!()();
import lib.io;
