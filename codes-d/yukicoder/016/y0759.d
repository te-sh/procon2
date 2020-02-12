// URL: https://yukicoder.me/problems/no/759

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  struct S { int P, T, R, i; }
  S[] s; io.getS!("P", "T", "R")(N, s);
  foreach (i, ref si; s) {
    ++si.P; ++si.T; ++si.R;
    si.i = cast(int)i;
  }

  s.multiSort!("a.P>b.P", "a.T>b.T", "a.R>b.R");

  auto st = new SegmentTree!(max, int)(10^^4+2), b = new bool[](N);
  b[] = true;

  foreach (si; s) {
    if (st[si.T..$] >= si.R)
      b[si.i] = false;

    st[si.T] = max(st[si.T], si.R);
  }

  foreach (i; 0..N)
    if (b[i]) io.put(i+1);
}

import lib.data_structure.segment_tree;

auto io = IO!()();
import lib.io;
