// URL: https://yukicoder.me/problems/no/46

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int a, b; io.getV(a, b);
  io.put((b+a-1)/a);
}

auto io = IO!()();
import lib.io;
