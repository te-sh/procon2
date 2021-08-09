// URL: https://yukicoder.me/problems/no/756

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  auto s = "0";
  foreach (i; 1..100) s ~= i.to!string;

  int D; io.getV(D);
  io.put(s[D]);
}

auto io = IO!()();
import lib.io;
