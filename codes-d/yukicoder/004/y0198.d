// URL: https://yukicoder.me/problems/no/198

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  long B; io.getV(B);
  int N; io.getV(N);
  long[] C; io.getC(N, C);

  C.sort;
  auto s = (B+C.sum)/N;
  io.put(C.map!(Ci => abs(Ci-min(s, C[(N-1)/2]))).sum);
}

auto io = IO!()();
import lib.io;
