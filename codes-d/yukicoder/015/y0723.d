// URL: https://yukicoder.me/problems/no/723
// URL: 

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, X; io.getV(N, X);
  int[] a; io.getA(N, a);

  auto as = a.sort, r = 0L;
  foreach (i; 0..N) r += as.equalRange(X-a[i]).length;
  io.put(r);
}

auto io = IO!()();
import lib.io;
