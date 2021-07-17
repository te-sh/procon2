// URL: https://atcoder.jp/contests/abc147/tasks/abc147_b

import std;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  auto n = S.length.to!int;

  auto r = 0;
  foreach (i; 0..n/2)
    if (S[i] != S[$-i-1])
      ++r;
  io.put(r);
}

auto io = IO!()();
import lib.io;
