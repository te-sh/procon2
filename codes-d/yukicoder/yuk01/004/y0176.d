// URL: https://yukicoder.me/problems/no/176

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int A, B, T; io.getV(A, B, T);

  auto r = int.max;
  foreach (y; 0..min(A, cdiv(T, B))+1) {
    auto s = T-B*y;
    if (s == 0)
      r.minU(B*y);
    else
      r.minU(B*y + cdiv(s, A)*A);
  }

  io.put(r);
}

import lib.minmax;

import lib.math.misc;

auto io = IO!()();
import lib.io;
