// URL: https://yukicoder.me/problems/no/740

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M, P, Q; io.getV(N, M, P, Q);

  auto r = 1;
  for (;;)
    foreach (mo; 1..13) {
      N -= M;
      if (mo >= P && mo < P+Q) N -= M;
      if (N <= 0) { io.put(r); return; }
      ++r;
    }
}

auto io = IO!()();
import lib.io;
