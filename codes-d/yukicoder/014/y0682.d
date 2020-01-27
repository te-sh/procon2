// URL: https://yukicoder.me/problems/no/682

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int a, b; io.getV(a, b);

  auto ans = 0;
  foreach (i; a..b+1)
    if ((a+b+i)%3 == 0) ++ans;

  io.put(ans);
}

auto io = IO!()();
import lib.io;
