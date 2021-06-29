// URL: https://atcoder.jp/contests/abc148/tasks/abc148_a

import std;

version(unittest) {} else
void main()
{
  auto r = [[0, 3, 2], [3, 0, 1], [2, 1, 0]];
  int A; io.getV(A);
  int B; io.getV(B);
  io.put(r[A-1][B-1]);
}

auto io = IO!()();
import lib.io;
