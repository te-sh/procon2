// URL: https://yukicoder.me/problems/no/744

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.put("285714"[(N-1)%6]);
}

auto io = IO!()();
import lib.io;
