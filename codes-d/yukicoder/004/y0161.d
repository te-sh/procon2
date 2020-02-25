// URL: https://yukicoder.me/problems/no/161

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int[] c; io.getA(3, c);
  string S; io.getV(S);

  auto d = new int[](3);
  foreach (Si; S)
    ++d[Si.predSwitch('G', 0, 'C', 1, 'P', 2)];

  auto r = 0;

  foreach (i; 0..3) {
    auto t = min(c[i], d[(i+1)%3]);
    r += t*3;
    c[i] -= t;
    d[(i+1)%3] -= t;
  }

  foreach (i; 0..3) {
    auto t = min(c[i], d[i]);
    r += t;
    c[i] -= t;
    d[i] -= t;
  }

  io.put(r);
}

auto io = IO!()();
import lib.io;
