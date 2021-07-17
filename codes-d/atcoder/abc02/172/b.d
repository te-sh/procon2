// URL: https://atcoder.jp/contests/abc172/tasks/abc172_b

import std;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  string T; io.getV(T);

  auto c = 0;
  foreach (Si, Ti; lockstep(S, T))
    if (Si != Ti) ++c;
  io.put(c);
}

auto io = IO!()();
import lib.io;
