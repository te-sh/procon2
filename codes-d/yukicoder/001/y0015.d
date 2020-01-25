// URL: https://yukicoder.me/problems/no/15

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;
import std.bitmanip;

version(unittest) {} else
void main()
{
  int N, S; io.getV(N, S);
  int[] P; io.getC(N, P);

  auto n1 = N/2, n2 = N-n1;

  auto p1 = new int[](1<<n1); p1[0] = 0;
  foreach (i; 1..1<<n1) {
    auto b = i.bsr;
    p1[i] = p1[i.bitReset(b)] + P[b];
  }

  struct MP { int m, p; }
  auto mp2 = new MP[](1<<n2); mp2[0] = MP(0, 0);
  foreach (i; 1..1<<n2) {
    auto b = i.bsr;
    mp2[i] = MP(i, mp2[i.bitReset(b)].p + P[n1+b]);
  }
  mp2.sort!"a.p<b.p";
  auto bs = mp2.assumeSorted!"a.p<b.p";

  size_t[][] ans;
  foreach (i; 0..1<<n1)
    foreach (mp2i; bs.equalRange(MP(0, S-p1[i])))
      ans ~= i.bitsSet.chain(mp2i.m.bitsSet.map!(mi => mi+n1)).array;
  ans.sort;

  foreach (ansi; ans) io.put(ansi.map!"a+1");
}

import lib.bitop;

auto io = IO!()();
import lib.io;
