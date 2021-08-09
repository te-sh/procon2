// URL: https://yukicoder.me/problems/no/159

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  double p, q; io.getV(p, q);
  io.putB(1-p < p*(1-q), "YES", "NO");
}

auto io = IO!()();
import lib.io;
