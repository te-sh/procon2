// URL: https://atcoder.jp/contests/abc143/tasks/abc143_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] d; io.getA(N, d);

  auto r = 0;
  foreach (i; 0..N-1)
    foreach (j; i+1..N)
      r += d[i]*d[j];
  io.put(r);
}

auto io = IO!()();
import lib.io;
