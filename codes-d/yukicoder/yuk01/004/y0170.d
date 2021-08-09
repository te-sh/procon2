// URL: https://yukicoder.me/problems/no/170

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  dchar[] S; io.getV(S);

  S.sort;
  bool[string] b;
  foreach (t; S.permutations) b[t.to!string] = true;

  io.put(b.length-1);
}

auto io = IO!()();
import lib.io;
