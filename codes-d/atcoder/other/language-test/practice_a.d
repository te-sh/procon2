// URL: https://atcoder.jp/contests/language-test-202001/tasks/practice_1

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int a; io.getV(a);
  int b, c; io.getV(b, c);
  string s; io.getV(s);
  io.put(a+b+c, s);
}

auto io = IO!()();
import lib.io;
