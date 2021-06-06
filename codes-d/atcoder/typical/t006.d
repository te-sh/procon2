// URL: https://atcoder.jp/contests/typical90/tasks/typical90_f

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);
  string S; io.getV(S);

  auto T = new C[](N);
  foreach (i, c; S) T[i] = C(c, i.to!int);

  auto s = segmentTree!((a, b) => a.c == b.c ? (a.i < b.i ? a : b) : (a.c < b.c ? a : b))(T, C('z'+1, N));
  auto c = size_t(0), r = new char[](K);
  foreach (i; 0..K) {
    auto t = s[c..N-K+i+1];
    r[i] = t.c;
    c = t.i+1;
  }

  io.put(r);
}

struct C
{
  char c;
  int i;
}

import lib.data_structure.segment_tree;

auto io = IO!()();
import lib.io;

