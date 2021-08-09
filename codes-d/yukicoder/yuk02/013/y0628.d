// URL: https://yukicoder.me/problems/no/628

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  int[string] score;
  foreach (_; 0..N) {
    int No; io.getV(No);
    int M, S; io.getV(M, S);
    string[] T; io.getA(M, T);
    foreach (Ti; T) score[Ti] += S;
  }

  struct TS { string t; int s; }
  TS[] ts;
  foreach (ti; score.byKey) ts ~= TS(ti, score[ti]);
  ts.multiSort!("a.s>b.s", "a.t<b.t");

  foreach (tsi; ts[0..min(ts.length, 10)])
    io.put(tsi.t, tsi.s);
}

auto io = IO!()();
import lib.io;
