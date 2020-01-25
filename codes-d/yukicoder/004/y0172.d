// URL: https://yukicoder.me/problems/no/172

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  int x, y, r; io.getV(x, y, r);
  io.put(x.abs+y.abs+((sqrt(2.0)*r).ceil).to!int);
}

auto io = IO!()();
import lib.io;
