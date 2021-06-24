// URL: https://atcoder.jp/contests/abc142/tasks/abc142_a

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  io.put(cdiv(N, 2).to!double/N);
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
