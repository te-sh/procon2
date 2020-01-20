// URL: https://yukicoder.me/problems/no/11

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  long W; io.getV(W);
  long H; io.getV(H);
  int N; io.getV(N);
  int[] S, K; io.getC(N, S, K);

  S.sort(); K.sort();
  io.put(W*H - (W-S.uniq.walkLength)*(H-K.uniq.walkLength) - N);
}

auto io = IO!()();
import lib.io;
