// URL: https://yukicoder.me/problems/no/728

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);
  int[] L, R; io.getC(N, L, R);

  struct B { int x, i, t; }
  auto b = new B[](N*2);
  foreach (i; 0..N) {
    b[i] = B(A[i], i, 0);
    b[i+N] = B(A[i]-L[i], i, 1);
  }
  b.multiSort!("a.x<b.x", "a.t>b.t");

  auto as = A.assumeSorted, ft = fenwickTree!int(N), ans = 0L;

  foreach (bi; b) {
    auto i = bi.i;
    switch (bi.t) {
    case 0:
      auto k = as.lowerBound(A[i]+R[i]+1).length;
      ans += ft[i+1..k];
      break;
    case 1:
      ++ft[i];
      break;
    default:
      assert(0);
    }
  }

  io.put(ans);
}

import lib.data_structure.fenwick_tree;

auto io = IO!()();
import lib.io;
