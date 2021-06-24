// URL: https://atcoder.jp/contests/abc141/tasks/abc141_e

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  string S; io.getV(S);

  auto sa = SuffixArray(S);
  auto lcp = LcpArray(sa);
  auto st = lcp[1..$].sparseTable;

  auto r = 0;
  foreach (i; 0..N)
    foreach (j; i+1..N) {
      auto l = st[i..j], x = sa.x[i], y = sa.x[j];
      if (x < y && x + l <= y || x > y && y + l <= x)
        r.maxU(l.to!int);
    }

  io.put(r);
}

import lib.minmax;
import lib.string.suffix_array;
import lib.string.lcp_array;
import lib.data_structure.sparse_table;

auto io = IO!()();
import lib.io;
