// URL: https://yukicoder.me/problems/no/690

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);

  io.put(32, 30*31/2+K.popcnt);
  foreach (i; 1..32)
    foreach (j; 1..i)
      io.put(j, i);

  foreach (i; 0..30)
    if (K.bitTest(i))
      io.put(i+2, 32);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
