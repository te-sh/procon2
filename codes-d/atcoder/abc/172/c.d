// URL: https://atcoder.jp/contests/abc172/tasks/abc172_c

import std;

version(unittest) {} else
void main()
{
  int N, M, K; io.getV(N, M, K);
  long[] A; io.getA(N, A);
  long[] B; io.getA(M, B);

  auto a = A.cumulativeSum, b = B.cumulativeSum;
  auto bs = b.s[1..$].assumeSorted;

  auto c = 0;
  foreach (i; 0..N+1) {
    auto r = K-a[0..i];
    if (r < 0) continue;
    c.maxU(i + bs.lowerBound(r+1).length.to!int);
  }
  io.put(c);
}

import lib.minmax;
import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
