// URL: https://yukicoder.me/problems/no/311

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long N; io.getV(N);
  io.put((N/3+N/5)*2);
}

auto io = IO!()();
import lib.io;
