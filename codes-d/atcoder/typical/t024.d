// URL: https://atcoder.jp/contests/typical90/tasks/typical90_x

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] A; io.getA(N, A);
  int[] B; io.getA(N, B);

  auto s = 0L;
  foreach (Ai, Bi; lockstep(A, B)) s += abs(Ai-Bi);

  io.putB(K >= s && (K-s)%2 == 0, "Yes", "No");
}

auto io = IO!()();
import lib.io;
