// URL: https://yukicoder.me/problems/no/706

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto t = new int[](1000);
  foreach (i; 0..N) {
    string S; io.getV(S);
    ++t[S.length-2];
  }

  auto m = 0, e = 0;
  foreach (i; 0..1000)
    if (t[i] >= m) {
      m = t[i];
      e = i;
    }

  io.put(e);
}

auto io = IO!()();
import lib.io;
