// URL: https://atcoder.jp/contests/abc147/tasks/abc147_a

import std;

version(unittest) {} else
void main()
{
  int A1, A2, A3; io.getV(A1, A2, A3);
  io.putB(A1+A2+A3 >= 22, "bust", "win");
}

auto io = IO!()();
import lib.io;
