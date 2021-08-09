// URL: https://yukicoder.me/problems/no/668

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.conv, std.format;

version(unittest) {} else
void main()
{
  string N; io.getV(N);
  int a = N[0..2].to!int;
  if (N[2] >= '5') ++a;
  if (a == 100)
    io.put(format("1.0*10^%d", N.length));
  else
    io.put(format("%d.%d*10^%d", a/10, a%10, N.length-1));
}

auto io = IO!()();
import lib.io;
