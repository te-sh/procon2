// URL: https://atcoder.jp/contests/aising2020/tasks/aising2020_b

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] a; io.getA(N, a);

  auto c = 0;
  foreach (i, ai; a)
    if (i%2 == 0 && ai%2 == 1)
      ++c;
  io.put(c);
}

auto io = IO!()();
import lib.io;
