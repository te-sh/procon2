// URL: https://atcoder.jp/contests/abc149/tasks/abc149_e

import std;

version(unittest) {} else
void main()
{
  long N, M; io.getV(N, M);
  long[] A; io.getA(N, A);
  auto a = A.sort!"a>b", c = A.cumulativeSum;

  auto m = a[0]*2, s = new long[](m+1), h = new long[](m+1);
  auto sh(long x)
  {
    s[x] = h[x] = 0;
    foreach (ai; a) {
      auto i = a.lowerBound(x-ai-1).length.to!long;
      s[x] += i;
      h[x] += c[0..i] + ai*i;
    }
    return s[x];
  }

  auto x = iota(1, m+1).upperBoundBy!(x => sh(x), "a>=b")(M).front;
  io.put(h[x] + (M-s[x])*(x-1));
}

import lib.bound_by;
import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
