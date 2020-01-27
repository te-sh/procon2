// URL: https://yukicoder.me/problems/no/671

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv;

version(unittest) {} else
void main()
{
  string N; io.getV(N);
  io.put((N.length.to!int-"1000000007".length.to!int).abs);
}

auto io = IO!()();
import lib.io;
