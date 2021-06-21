// URL: https://atcoder.jp/contests/abc136/tasks/abc136_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.put(iota(1, N+1).count!(a => a.to!string.length % 2 == 1));
}

auto io = IO!()();
import lib.io;
