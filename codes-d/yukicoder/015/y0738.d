// URL: https://yukicoder.me/problems/no/738

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  int[] A; io.getA(N, A);

  auto za = Zaatsu!int(A);
  auto c = za.comp(A).array;

  auto fc = fenwickTree!int(za.n), fs = fenwickTree!long(za.n);
  foreach (i; 0..K) {
    fc[c[i]] += 1;
    fs[c[i]] += za.uncomp(c[i]);
  }

  auto ans = 10L^^18;
  foreach (i; 0..N-K+1) {
    auto s = iota(0, za.n).map!(j => fc[0..j]).assumeSorted;
    if (K%2 == 0) {
      auto j1 = cast(int)s.lowerBound(K/2).length-1, j2 = cast(int)s.lowerBound(K/2+1).length-1;
      auto f1 = fs[j2..$]-cast(long)za.uncomp(j2)*(fc[j2..$]-K/2);
      auto f2 = fs[0..j1+1]-cast(long)za.uncomp(j1)*(fc[0..j1+1]-K/2);
      ans = min(ans, f1-f2);
    } else {
      auto j = cast(int)s.lowerBound(K/2+1).length-1;
      auto f1 = fs[j..$]-cast(long)za.uncomp(j)*(fc[j..$]-K/2);
      auto f2 = fs[0..j+1]-cast(long)za.uncomp(j)*(fc[0..j+1]-K/2);
      ans = min(ans, f1-f2);
    }

    if (i < N-K) {
      fc[c[i]] -= 1;
      fs[c[i]] -= za.uncomp(c[i]);
      fc[c[i+K]] += 1;
      fs[c[i+K]] += za.uncomp(c[i+K]);
    }
  }

  io.put(ans);
}

import lib.data_structure.zaatsu;

import lib.data_structure.fenwick_tree;

auto io = IO!()();
import lib.io;
