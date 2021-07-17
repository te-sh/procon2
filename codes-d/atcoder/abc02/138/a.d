// URL: https://atcoder.jp/contests/abc138/tasks/abc138_a

import std;

version(unittest) {} else
void main()
{
  int a; io.getV(a);
  string s; io.getV(s);
  io.putB(a >= 3200, s, "red");
}

auto io = IO!()();
import lib.io;
