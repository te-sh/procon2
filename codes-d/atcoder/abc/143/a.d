// URL: https://atcoder.jp/contests/abc143/tasks/abc143_a

import std;

version(unittest) {} else
void main()
{
  int A, B; io.getV(A, B);
  io.put(max(A-B*2, 0));
}

auto io = IO!()();
import lib.io;
