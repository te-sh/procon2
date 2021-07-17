// URL: https://atcoder.jp/contests/abc137/tasks/abc137_b

import std;

version(unittest) {} else
void main()
{
  int K, X; io.getV(K, X);
  io.put(iota(X-K+1, X+K));
}

auto io = IO!()();
import lib.io;
