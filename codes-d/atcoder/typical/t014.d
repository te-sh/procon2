// URL: https://atcoder.jp/contests/typical90/tasks/typical90_n

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);
  int[] B; io.getA(N, B);

  A.sort; B.sort;
  auto t = 0L;
  foreach (Ai, Bi; lockstep(A, B)) t += abs(Ai-Bi);

  io.put(t);
}

auto io = IO!()();
import lib.io;
