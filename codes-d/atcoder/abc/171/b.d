// URL: https://atcoder.jp/contests/abc171/tasks/abc171_b

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] p; io.getA(N, p);

  p.sort;
  io.put(p[0..K].sum);
}

auto io = IO!()();
import lib.io;
