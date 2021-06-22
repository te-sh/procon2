// URL: https://atcoder.jp/contests/abc139/tasks/abc139_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] H; io.getA(N, H);

  auto r = 0, j = 0;
  foreach (i; 0..N-1) {
    if (H[i] < H[i+1]) {
      r.maxU(i-j);
      j = i+1;
    }
  }
  r.maxU(N-1-j);

  io.put(r);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
