// URL: https://yukicoder.me/problems/no/721

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.datetime, std.format, core.time;

version(unittest) {} else
void main()
{
  string s; io.getV(s);

  auto d = Date(s[0..4].to!int, s[5..7].to!int, s[8..10].to!int);
  d += 2.days;

  io.put(format("%04d/%02d/%02d", d.year, d.month, d.day));
}

auto io = IO!()();
import lib.io;
