// URL: https://atcoder.jp/contests/abc149/tasks/abc149_c

import std;

version(unittest) {} else
void main()
{
  int X; io.getV(X);

 loop: for (auto n = X; ; ++n) {
    foreach (f; 2..isqrt(n)+1)
      if (n%f == 0) continue loop;
    io.putE(n);
  }
}

import lib.math.isqrt;

auto io = IO!()();
import lib.io;
