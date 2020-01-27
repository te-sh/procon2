// URL: https://yukicoder.me/problems/no/688

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int K; io.getV(K);

  foreach (long x; 0..31)
    foreach (long y; 0..31)
      if (x+y >= 1 && x+y <= 30 && 2^^x*y*(y-1)/2 == K) {
        io.put(x+y);
        io.put(chain(0.repeat.take(x), 1.repeat.take(y)));
        return;
      }
}

auto io = IO!()();
import lib.io;
