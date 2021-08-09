// URL: https://yukicoder.me/problems/no/651

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.format;

version(unittest) {} else
void main()
{
  int a; io.getV(a);
  auto m = a/10*6;
  io.put(format("%02d:%02d", 10+m/60, m%60));
}

auto io = IO!()();
import lib.io;
