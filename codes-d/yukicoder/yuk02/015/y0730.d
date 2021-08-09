// URL: https://yukicoder.me/problems/no/730

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);

  auto c = new int[](26);
  foreach (Si; S) ++c[Si-'A'];

  io.putB(c.all!"a <= 1", "YES", "NO");
}

auto io = IO!()();
import lib.io;
