// URL: https://atcoder.jp/contests/abc175/tasks/abc175_a

import std;

version(unittest) {} else
void main()
{
  auto h = ["SSS": 0, "SSR": 1, "SRS": 1, "SRR": 2, "RSS": 1, "RSR": 1, "RRS": 2, "RRR": 3];
  string S; io.getV(S);
  io.put(h[S]);
}

auto io = IO!()();
import lib.io;
