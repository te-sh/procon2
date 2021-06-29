// URL: https://atcoder.jp/contests/abc146/tasks/abc146_a

import std;

version(unittest) {} else
void main()
{
  const h = ["SUN": 7, "MON": 6, "TUE": 5, "WED": 4, "THU": 3, "FRI": 2, "SAT": 1];
  string S; io.getV(S);
  io.put(h[S]);
}

auto io = IO!()();
import lib.io;
