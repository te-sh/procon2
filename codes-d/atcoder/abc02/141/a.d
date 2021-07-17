// URL: https://atcoder.jp/contests/abc141/tasks/abc141_a

import std;

version(unittest) {} else
void main()
{
  auto h = ["Sunny": "Cloudy", "Cloudy": "Rainy", "Rainy": "Sunny"];
  string S; io.getV(S);
  io.put(h[S]);
}

auto io = IO!()();
import lib.io;
