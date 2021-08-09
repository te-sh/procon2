// URL: https://yukicoder.me/problems/no/169

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);
  int S; io.getV(S);
  io.put(S*100/(100-K));
}

auto io = IO!()();
import lib.io;
