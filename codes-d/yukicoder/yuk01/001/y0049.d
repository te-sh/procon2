// URL: https://yukicoder.me/problems/no/49

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.regex;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  auto m = S.matchAll(r"(\+|\*)?(\d+)"), r = 0;
  foreach (mi; m) {
    if (mi[1] == "" || mi[1] == "*")
      r += mi[2].to!int;
    else
      r *= mi[2].to!int;
  }
  io.put(r);
}

auto io = IO!()();
import lib.io;
