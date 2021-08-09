// URL: https://yukicoder.me/problems/no/700

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int n, m; io.getV(n, m);
  string[] s; io.getC(n, s);
  io.putB(s.any!(si => si.canFind("LOVE")), "YES", "NO");
}

auto io = IO!()();
import lib.io;
