// URL: https://atcoder.jp/contests/abc148/tasks/abc148_e

import std;

version(unittest) {} else
void main()
{
  long N; io.getV(N);

  if (N%2 != 0) io.putE(0);

  auto r = 0L;
  foreach (i; 1..27)
    r += N/2/(5L^^i);
  io.put(r);
}

auto io = IO!()();
import lib.io;
