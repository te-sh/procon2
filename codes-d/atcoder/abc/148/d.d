// URL: https://atcoder.jp/contests/abc148/tasks/abc148_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);

  auto i = 0, j = ptrdiff_t(0);
  while ((j = a.countUntil(i+1)) != -1) {
    ++i;
    a = a[j+1..$];
  }

  io.putB(i == 0, -1, N-i);
}

auto io = IO!()();
import lib.io;
