// URL: https://yukicoder.me/problems/no/184

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  long[] A; io.getA(N, A);

  auto i = 0, j = 0;
  while (i <= 60 && j < N) {
    auto k = A[j..$].countUntil!(Ai => Ai.bitTest(i));
    if (k == -1) {
      ++i;
      continue;
    }
    k += j;
    swap(A[j], A[k]);
    foreach (l; 0..N)
      if (l != j && A[l].bitTest(i)) A[l] ^= A[j];
    ++i; ++j;
  }

  io.put(2L^^(A.count!"a>0"));
}

import lib.bitop;

auto io = IO!()();
import lib.io;
