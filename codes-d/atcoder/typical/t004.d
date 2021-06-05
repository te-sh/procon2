// URL: https://atcoder.jp/contests/typical90/tasks/typical90_d

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int H, W; io.getV(H, W);
  int[][] A; io.getM(H, W, A);

  auto S = new int[](H), T = new int[](W);
  foreach (i; 0..H)
    foreach (j; 0..W) {
      S[i] += A[i][j];
      T[j] += A[i][j];
    }

  auto B = new int[][](H, W);
  foreach (i; 0..H)
    foreach (j; 0..W)
      B[i][j] = S[i] + T[j] - A[i][j];

  foreach (Bi; B) io.put(Bi);
}

auto io = IO!()();
import lib.io;
