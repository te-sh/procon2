// URL: https://yukicoder.me/problems/no/151

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, Q; io.getV(N, Q);

  auto n = N*2, ft = new FenwickTree!long(n);
  foreach (t; 0..Q) {
    string x; int y, z; io.getV(x, y, z);
    switch (x) {
    case "L":
      ft[(y+t)%n] += z;
      break;
    case "R":
      ft[(n-1-y+t)%n] += z;
      break;
    case "C":
      auto r = 0L;
      auto u1 = (y+t)%n, v1 = (z-1+t)%n+1;
      r += u1 < v1 ? ft[u1..v1] : ft[0..v1]+ft[u1..n];
      auto u2 = (n-y+t-1)%n+1, v2 = (n-z+t)%n;
      r += v2 < u2 ? ft[v2..u2] : ft[0..u2]+ft[v2..n];
      io.put(r);
      break;
    default:
      assert(0);
    }
  }
}

import lib.data_structure.fenwick_tree;

auto io = IO!()();
import lib.io;
