// URL: https://atcoder.jp/contests/abc143/tasks/abc143_d

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] L; io.getA(N, L);
  L.sort;

  auto r = 0;
  foreach (i; 0..N-2)
    foreach (j; i+1..N-1)
      r += L[j+1..$].assumeSorted.lowerBound(L[i]+L[j]).length.to!int;
  io.put(r);
}

auto io = IO!()();
import lib.io;
