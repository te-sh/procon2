// URL: https://atcoder.jp/contests/typical90/tasks/typical90_ag

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  if (H == 1) {
    io.put(W);
  } else if (W == 1) {
    io.put(H);
  } else {
    io.put(((H+1)/2) * ((W+1)/2));
  }
}

auto io = IO!()();
import lib.io;
