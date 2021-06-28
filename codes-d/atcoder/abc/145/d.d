// URL: https://atcoder.jp/contests/abc145/tasks/abc145_d

import std;

version(unittest) {} else
void main()
{
  int X, Y; io.getV(X, Y);

  auto x = Y*2-X, y = X*2-Y;
  if (x%3 != 0 || y%3 != 0 || x < 0 || y < 0)
    io.put!"{exit: true}"(0);
  x /= 3; y /= 3;

  auto f = Fact!mint(x+y);
  io.put(f.combi(x+y, x));
}

const mod = 10^^9+7;
alias mint = ModInt!mod;

import lib.math.fact;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
