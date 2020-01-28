// URL: https://yukicoder.me/problems/no/722

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.regex;

version(unittest) {} else
void main()
{
  string A, B; io.getV(A, B);

  if (!A.matchFirst(r"^-?\d00+$").empty && !B.matchFirst(r"^-?\d00+$").empty) {
    io.put(A.to!long * B.to!long / 10);
  } else {
    auto r = A.to!long * B.to!long;
    io.putB(r > -10^^8 && r < 10^^8, r, "E");
  }
}

auto io = IO!()();
import lib.io;
