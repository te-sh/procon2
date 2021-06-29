// URL: https://atcoder.jp/contests/abc147/tasks/abc147_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  long[] A; io.getA(N, A);

  auto m = 60, r = mint(0);
  foreach (k; 0..m) {
    auto a = 0, b = 0;
    foreach (Ai; A)
      if (Ai.bitTest(k))
        ++a;
      else
        ++b;
    r += mint(2)^^k * a * b;
  }

  io.put(r);
}

const mod = 10^^9+7;
alias mint = ModInt!mod;

import lib.bitop;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
