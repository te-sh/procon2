// URL: https://yukicoder.me/problems/no/169

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);
  int S; io.getV(S);
  io.put(S*100/(100-K));
}

auto io = IO!()();
import lib.io;
