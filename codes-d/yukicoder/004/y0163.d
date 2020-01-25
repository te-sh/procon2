// URL: https://yukicoder.me/problems/no/163

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.uni;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  io.put(S.map!(c => c.isLower ? c.toUpper : c.toLower).to!string);
}

auto io = IO!()();
import lib.io;
