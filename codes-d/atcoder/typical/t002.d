// URL: https://atcoder.jp/contests/typical90/tasks/typical90_b

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto available(int i)
  {
    int c = 0;
    foreach_reverse (j; 0..N) {
      c += i.bitTest(j) ? -1 : +1;
      if (c < 0) return false;
    }
    return c == 0;
  }

  foreach (i; 0..1<<N) {
    if (available(i)) {
      char[] s = new char[](N);
      foreach (j; 0..N) {
        s[j] = i.bitTest(j) ? ')' : '(';
      }
      io.put(s.reverse);
    }
  }
}

import lib.bitop;

auto io = IO!()();
import lib.io;
