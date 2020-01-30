// URL: https://yukicoder.me/problems/no/742

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] M; io.getC(N, M);

  auto ft = fenwickTree!int(N+1);

  auto r = 0L;
  foreach (Mi; M) {
    r += ft[Mi..$];
    ++ft[Mi];
  }

  io.put(r);
}

import lib.data_structure.fenwick_tree;

auto io = IO!()();
import lib.io;
