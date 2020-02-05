// URL: https://yukicoder.me/problems/no/190

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N*2, A);

  A.sort;

  auto calcDry()
  {
    auto i = 0, j = N*2-1, r = 0;
    while (i < j) {
      if (A[i]+A[j] < 0) {
        ++r; ++i; --j;
      } else {
        --j;
      }
    }
    return r;
  }

  auto calcWet()
  {
    auto i = 0, j = N*2-1, r = 0;
    while (i < j) {
      if (A[i]+A[j] > 0) {
        ++r; ++i; --j;
      } else {
        ++i;
      }
    }
    return r;
  }

  auto calcMoist()
  {
    auto i = 0, j = N*2-1, r = 0;
    while (i < j) {
      if (A[i]+A[j] == 0) {
        ++r; ++i; --j;
      } else if (A[i]+A[j] < 0) {
        ++i;
      } else {
        --j;
      }
    }
    return r;
  }

  io.put(calcDry(), calcWet(), calcMoist());
}

auto io = IO!()();
import lib.io;
