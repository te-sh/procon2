// URL: https://yukicoder.me/problems/no/166

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long H, W, N, K; io.getV(H, W, N, K);
  io.putB((H*W-1)%N == K-1, "YES", "NO");
}

auto io = IO!()();
import lib.io;
