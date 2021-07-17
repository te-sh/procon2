// URL: https://atcoder.jp/contests/abc142/tasks/abc142_b

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] h; io.getA(N, h);
  io.put(h.count!(hi => hi >= K));
}

auto io = IO!()();
import lib.io;
