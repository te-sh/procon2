// URL: https://yukicoder.me/problems/no/5

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int L; io.getV(L);
  int N; io.getV(N);
  int[] W; io.getA(N, W);

  W.sort;
  io.put(W.cumulativeFold!"a+b".array.assumeSorted.lowerBound(L+1).length); 
}

auto io = IO!()();
import lib.io;
