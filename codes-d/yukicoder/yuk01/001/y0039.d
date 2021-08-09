// URL: https://yukicoder.me/problems/no/39

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string N; io.getV(N);

  auto r = N.dup;
  foreach (i; 0..N.length)
    foreach (j; i+1..N.length) {
      auto t = N.dup;
      swap(t[i], t[j]);
      r = max(r, t);
    }

  io.put(r);
}

auto io = IO!()();
import lib.io;
