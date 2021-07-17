// URL: https://atcoder.jp/contests/abc140/tasks/abc140_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] B; io.getA(N-1, B);

  auto r = B[0] + B[N-2];
  foreach (i; 1..N-1)
    r += min(B[i-1], B[i]);
  io.put(r);
}

auto io = IO!()();
import lib.io;
