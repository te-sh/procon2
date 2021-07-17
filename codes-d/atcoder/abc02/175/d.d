// URL: https://atcoder.jp/contests/abc175/tasks/abc175_d

import std;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] P; io.getA(N, P); P[] -= 1;
  long[] C; io.getA(N, C);

  auto v = new bool[](N), m = -10L^^18-1;
  foreach (i; 0..N) {
    if (v[i]) continue;
    auto j = i, cl = new long[](0);
    while (!v[j]) {
      cl ~= C[j];
      v[j] = true;
      j = P[j];
    }
    m.maxU(calc(cl, K));
  }

  io.put(m);
}

auto calc(long[] c, int K)
{
  auto cl = c.length.to!int, cs = c.sum, cc = c.cumulativeSum;

  auto m = -10L^^18-1;
  foreach (i; 0..cl)
    foreach (j; 1..cl+1) {
      auto l = j-i + (i<j ? 0 : cl);
      if (l > K) continue;

      auto s = i<j ? cc[i..j] : cc[i..$]+cc[0..j];
      if (cs > 0) s += cs*((K-l)/cl);
      m.maxU(s);
    }
  return m;
}

import lib.minmax;
import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
