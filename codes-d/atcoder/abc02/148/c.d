// URL: https://atcoder.jp/contests/abc148/tasks/abc148_c

import std;

version(unittest) {} else
void main()
{
  long A, B; io.getV(A, B);
  io.put(A*B / gcd(A, B));
}

auto io = IO!()();
import lib.io;
