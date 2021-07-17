// URL: https://atcoder.jp/contests/abc140/tasks/abc140_d

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  string S; io.getV(S);

  auto b = S.matchAll(r"(R+|L+)").walkLength.to!int;
  io.putB(b-K*2 <= 1, N-1, N-(b-K*2));
}

auto io = IO!()();
import lib.io;
