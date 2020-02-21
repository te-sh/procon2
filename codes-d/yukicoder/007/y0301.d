// URL: https://yukicoder.me/problems/no/301
import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int T; io.getV(T);

  auto m = Matrix!double(7, 7);
  foreach (i; 0..6) m[0][i] = 1.0/6;
  foreach (i; 0..5) m[i+1][i] = 1;
  m[0][6] = m[6][6] = 1;

  foreach (_; 0..T) {
    long N; io.getV(N);
    if (N < 100) {
      auto r = m^^N;
      io.put!`{floatFormat: "%.13f"}`(r[0][6]/(1-r[0][1..6].sum));
    } else {
      io.put!`{delimiter: ""}`(N+1, ".666666666666");
    }
  }
}

import lib.math.matrix;

auto io = IO!()();
import lib.io;
