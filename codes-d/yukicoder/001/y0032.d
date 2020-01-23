// URL: https://yukicoder.me/problems/no/32

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);
  int M; io.getV(M);
  int N; io.getV(N);

  M += N/25; N %= 25;
  L += M/4; M %= 4;
  auto K = L/10; L %= 10;

  io.put(L+M+N);
}

auto io = IO!()();
import lib.io;
