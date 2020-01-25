// URL: https://yukicoder.me/problems/no/653

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.regex;

version(unittest) {} else
void main()
{
  string p; io.getV(p);
  auto m = p.matchFirst(r"^(1[345]*[234]|[67]*[78][345]*[234])$");
  io.putB(!m.empty, "Yes", "No");
}

auto io = IO!()();
import lib.io;
