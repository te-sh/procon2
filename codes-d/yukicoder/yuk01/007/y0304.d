// URL: https://yukicoder.me/problems/no/304

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  foreach (i; 0..1000)
    if (query(i)) return;
}

auto query(int x)
{
  io.put!"{flush: true}"(format("%03d", x));
  string s; io.getV(s);
  return s == "unlocked";
}

auto io = IO!()();
import lib.io;
