// URL: https://yukicoder.me/problems/no/172

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int x, y, r; io.getV(x, y, r);
  io.put(x.abs+y.abs+((sqrt(2.0)*r).ceil).to!int);
}

auto io = IO!()();
import lib.io;
