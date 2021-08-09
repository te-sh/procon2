// URL: https://yukicoder.me/problems/no/761

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  long[] A; io.getA(N, A);

  auto as = A.assumeSorted, ac = A.cumulativeSum;

  bool calc(int l, int r)
  {
    if (A[l] == A[r-1]) return true;

    auto b = (ac[l..r]+(r-l)-1)/(r-l);
    auto i = cast(int)as.lowerBound(b).length;

    auto c1 = calc(l, i), c2 = calc(i, r);
    return !c1 || !c2;
  }

  io.putB(calc(0, N), "First", "Second");
}

import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
