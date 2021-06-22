// URL: https://atcoder.jp/contests/abc137/tasks/abc137_a

import std;

version(unittest) {} else
void main()
{
  int A, B; io.getV(A, B);
  io.put([A+B, A-B, A*B].maxElement);
}

auto io = IO!()();
import lib.io;
