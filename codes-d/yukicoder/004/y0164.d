// URL: https://yukicoder.me/problems/no/164

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto r = long.max;
  foreach (_; 0..N) {
    string s; io.getV(s);
    auto c = s.maxElement.toD+1;

    auto d = 0L;
    foreach (i, si; s)
      d += si.toD * c^^(s.length-i-1);

    r = min(r, d);
  }

  io.put(r);
}

auto toD(dchar c) { return cast(long)(c < 'A' ? c-'0' : c-'A'+10); }

auto io = IO!()();
import lib.io;

