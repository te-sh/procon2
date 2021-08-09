// URL: https://yukicoder.me/problems/no/676

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  io.put(S.replace("I", "1").replace("l", "1").replace("O", "0").replace("o", "0"));
}

auto io = IO!()();
import lib.io;
