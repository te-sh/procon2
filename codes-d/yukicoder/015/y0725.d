// URL: https://yukicoder.me/problems/no/725

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.regex;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  io.put(S.replaceAll(regex(r"treeone"), "forest"));
}

auto io = IO!()();
import lib.io;
