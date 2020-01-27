// URL: https://yukicoder.me/problems/no/694

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getC(N, A);

  auto b = A.dup.sort;
  auto za = Zaatsu!int(b);
  A = za.comp(A).array;

  b = A.dup.sort;

  auto t = 0L, ft = fenwickTree!int(za.n);
  foreach (Ai; A) ++ft[Ai];
  foreach (Ai; A) {
    t += ft[0..Ai];
    --ft[Ai];
  }

  foreach (Ai; A) {
    io.put(t);
    t -= b.lowerBound(Ai).length;
    t += b.upperBound(Ai).length;
  }
}

import lib.data_structure.zaatsu;

import lib.data_structure.fenwick_tree;

auto io = IO!()();
import lib.io;
