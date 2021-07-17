// URL: https://atcoder.jp/contests/abc137/tasks/abc137_c

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  dchar[][] s; io.getC(N, s);

  long[string] c;
  foreach (si; s)
    ++c[si.sort.to!string];

  io.put(c.byValue.map!(ci => ci*(ci-1)/2).sum);
}

auto io = IO!()();
import lib.io;
