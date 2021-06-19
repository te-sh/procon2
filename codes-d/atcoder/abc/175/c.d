// URL: https://atcoder.jp/contests/abc175/tasks/abc175_c

import std;

version(unittest) {} else
void main()
{
  long x, k, d; io.getV(x, k, d);
  if (x < 0) x = -x;
  BigInt X = x, K = k, D = d;

  if (X-K*D >= 0) io.put!"{exit: true}"(X-K*D);

  auto R = X % D;
  auto r = [R-D*2, R-D, R, R+D]
    .filter!(Y => (X-Y)/D <= K && ((X-Y)/D)%2 == K%2)
    .map!abs
    .minElement;
  io.put(r);
}

import lib.math.misc;

auto io = IO!()();
import lib.io;
