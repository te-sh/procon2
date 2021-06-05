// URL: https://atcoder.jp/contests/typical90/tasks/typical90_a

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, L; io.getV(N, L);
  int K; io.getV(K);
  int[] A; io.getA(N, A);

  auto B = new int[](N+1);
  B[0] = A[0];
  foreach (i; 0..N-1) B[i+1] = A[i+1]-A[i];
  B[N] = L-A[N-1];

  auto pieces(int x)
  {
    auto r = 0, p = 0;
    foreach (Bi; B) {
      r += Bi;
      if (r >= x) {
        ++p;
        r = 0;
      }
    }
    return p;
  }

  auto m = B.minElement;
  io.put(iota(m, L+1).lowerBoundBy!(x => pieces(x), "a>b")(K).back);
}

import lib.bound_by;

auto io = IO!()();
import lib.io;
