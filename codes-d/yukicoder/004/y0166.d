// URL: https://yukicoder.me/problems/no/166

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long H, W, N, K; io.getV(H, W, N, K);
  io.putB((H*W-1)%N == K-1, "YES", "NO");
}

auto io = IO!()();
import lib.io;
