// URL: https://yukicoder.me/problems/no/193

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;
import std.regex;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  auto n = S.length;

  auto calc(string s)
  {
    if (s[0] == '+' || s[0] == '-' || s[$-1] == '+' || s[$-1] == '-') return -10^^9;
    return s.matchAll(r"(\+|\-)?\d+").map!"a[0]".map!(to!int).sum;
  }

  S ~= S;
  io.put(n.iota.map!(i => calc(S[i..i+n])).maxElement);
}

auto io = IO!()();
import lib.io;
