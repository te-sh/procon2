// URL: https://atcoder.jp/contests/abc138/tasks/abc138_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  double[] v; io.getA(N, v);

  foreach (_; 0..N-1) {
    v.sort;
    v = v[2..$] ~ (v[0] + v[1])/2;
  }
  io.put(v[0]);
}

auto io = IO!()();
import lib.io;
