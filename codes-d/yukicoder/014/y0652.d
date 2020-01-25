// URL: https://yukicoder.me/problems/no/652

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.format, std.regex;

version(unittest) {} else
void main()
{
  int a, b; string S; io.getV(a, b, S);

  auto m = S.matchFirst(r"UTC(\+|-)(\d+)(\.(\d))?");
  auto c = m[1], d = m[2].to!int, e = m[4].empty ? 0 : m[4].to!int;

  a -= 9;
  if (c == "+") {
    a += d;
    b += e*6;
  } else {
    a -= d;
    b -= e*6;
  }

  if (b < 0)  { b += 60; --a; }
  if (b > 59) { b -= 60; ++a; }

  if (a < 0)  { a += 24; }
  if (a > 23) { a -= 24; }

  io.put(format("%02d:%02d", a, b));
}

auto io = IO!()();
import lib.io;
