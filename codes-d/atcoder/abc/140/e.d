// URL: https://atcoder.jp/contests/abc140/tasks/abc140_e

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] P; io.getA(N, P);

  auto a = new int[](N+1);
  foreach (i, Pi; P) a[Pi] = i.to!int;

  auto st = segmentTree!max(P);

  auto c = 0L;
  foreach (X; 1..N) {
    auto x = a[X];

    auto tl1 = iota(0, x).map!(i => st[i..x]).assumeSorted!"a>b".upperBound(X);
    auto l1 = x - tl1.length.to!long - 1;
    auto tl2 = iota(0, l1).map!(i => st[i..l1]).assumeSorted!"a>b".upperBound(X);
    auto l2 = l1 < 0 ? -1 : l1 - tl2.length.to!long - 1;

    auto tr1 = iota(x+1, N).map!(i => st[x+1..i+1]).assumeSorted!"a<b".lowerBound(X);
    auto r1 = x + tr1.length.to!long + 1;
    auto tr2 = iota(r1+1, N).map!(i => st[r1+1..i+1]).assumeSorted!"a<b".lowerBound(X);
    auto r2 = r1 >= N-1 ? N : r1 + tr2.length.to!long + 1;

    c += ((l1-l2)*(r1-x) + (x-l1)*(r2-r1)) * X;
  }

  io.put(c);
}

import lib.data_structure.segment_tree;

auto io = IO!()();
import lib.io;
