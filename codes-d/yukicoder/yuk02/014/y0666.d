// URL: https://yukicoder.me/problems/no/666

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const mod = 10^^9+7;

version(unittest) {} else
void main()
{
  long A, B; io.getV(A, B);
  io.put(A*B%mod);
}

auto io = IO!()();
import lib.io;
