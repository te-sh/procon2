// URL: https://yukicoder.me/problems/no/43

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string[] s; io.getC(N, s);

  struct G { int i, j; }
  G[] g;
  foreach (i; 0..N)
    foreach (j; i+1..N)
      if (s[i][j] == '-') g ~= G(i, j);
  auto ng = g.length;

  auto r = N;
  foreach (b; 0..1<<ng) {
    auto t = s.map!"a.dup".array;
    foreach (i, gi; g) {
      t[gi.i][gi.j] = b.bitTest(i) ? 'o' : 'x';
      t[gi.j][gi.i] = b.bitTest(i) ? 'x' : 'o';
    }

    auto w = t.map!"a.count('o')".array, w0 = w[0];
    r = min(r, cast(int)w.sort!"a>b".uniq.countUntil(w0)+1);
  }
  io.put(r);
}

import lib.bitop;

auto io = IO!()();
import lib.io;
