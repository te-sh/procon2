// URL: https://atcoder.jp/contests/aising2020/tasks/aising2020_a

import std;

version(unittest) {} else
void main()
{
  int L, R, d; io.getV(L, R, d);
  io.put(iota(L, R+1).count!(x => x%d == 0));
}

auto io = IO!()();
import lib.io;
