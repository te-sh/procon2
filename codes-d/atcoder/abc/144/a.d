// URL: https://atcoder.jp/contests/abc144/tasks/abc144_a

import std;

version(unittest) {} else
void main()
{
  int A, B; io.getV(A, B);
  io.putB(A <= 9 && B <= 9, A*B, -1);
}

auto io = IO!()();
import lib.io;
