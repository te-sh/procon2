// URL: https://yukicoder.me/problems/no/163

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;
import std.uni;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  io.put(S.map!(c => c.isLower ? c.toUpper : c.toLower).to!string);
}

auto io = IO!()();
import lib.io;
