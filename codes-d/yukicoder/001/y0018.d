// URL: https://yukicoder.me/problems/no/18

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  dchar[] s; io.getV(s);
  auto z = 26;

  foreach (i, ref si; s) {
    auto c1 = cast(int)si-'A';
    auto c2 = ((c1-cast(int)(i+1))%z+z)%z;
    si = cast(dchar)(c2+'A');
  }
  io.put(s);
}

auto io = IO!()();
import lib.io;
