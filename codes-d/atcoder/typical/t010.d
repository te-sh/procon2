// URL: https://atcoder.jp/contests/typical90/tasks/typical90_j

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  auto P = new int[][](2, N);
  foreach (i; 0..N) {
    int Ci, Pi; io.getV(Ci, Pi);
    P[Ci-1][i] = Pi;
  }

  auto S = cumulativeSum(P[0]), T = cumulativeSum(P[1]);

  int Q; io.getV(Q);
  foreach (_; 0..Q) {
    int Li, Ri; io.getV(Li, Ri);
    io.put(S[Li-1..Ri], T[Li-1..Ri]);
  }
}

import lib.data_structure.cumulative_sum;

auto io = IO!()();
import lib.io;
