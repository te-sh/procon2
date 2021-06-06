// URL: https://atcoder.jp/contests/typical90/tasks/typical90_af

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[][] A; io.getM(N, N, A);

  auto b = new bool[][](N, N);
  int M; io.getV(M);
  foreach (_; 0..M) {
    int Xi, Yi; io.getV(Xi, Yi); --Xi; --Yi;
    b[Xi][Yi] = b[Yi][Xi] = true;
  }

  auto p = new int[](N);
  foreach (i; 0..N) p[i] = i;

  auto t = 10^^5;
 loop: do {
    foreach (i; 0..N-1)
      if (b[p[i]][p[i+1]])
        continue loop;

    auto u = 0;
    foreach (i; 0..N) u += A[p[i]][i];
    t.minU(u);
  } while (p.nextPermutation);

  io.putB(t <= 10^^4, t, -1);
}

import lib.minmax;

auto io = IO!()();
import lib.io;
