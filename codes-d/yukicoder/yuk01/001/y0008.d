// URL: https://yukicoder.me/problems/no/8

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int P; io.getV(P);

  foreach (_; 0..P) {
    int N, K; io.getV(N, K);
    io.putB(N%(K+1) != 1, "Win", "Lose");
  }
}

auto io = IO!()();
import lib.io;
