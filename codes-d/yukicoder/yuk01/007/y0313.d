// URL: https://yukicoder.me/problems/no/313

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  string s; io.getV(s);
  auto a = new int[](10);
  foreach (c; s.filter!(c => c != '.')) ++a[c-'0'];
  a[] -= b[];
  io.put(a.maxIndex, a.minIndex);
}

const b = [20104, 20063, 19892, 20011, 19874, 20199, 19898, 20163, 19956, 19841];

auto io = IO!()();
import lib.io;
