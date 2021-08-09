// URL: https://yukicoder.me/problems/no/711

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

const inf = 10^^9+1;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);

  foreach (i; 0..N) A[i] -= i;
  auto b = A.filter!"a>0".array;
  auto m = cast(int)b.length;

  auto dp = new int[](m);
  dp[] = inf;

  foreach (i; 0..m) {
    auto bs = dp.assumeSorted.lowerBound(b[i]+1);
    dp[bs.length] = b[i];
  }

  io.put(N-cast(int)dp.assumeSorted.lowerBound(inf).length);
}

auto io = IO!()();
import lib.io;
