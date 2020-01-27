// URL: https://yukicoder.me/problems/no/672

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);

  int[int] h;
  auto a = 0;
  foreach (i, c; S) {
    a += c == 'A' ? +1 : -1;
    h[a] = cast(int)i;
  }

  a = 0;
  auto l = 0;
  foreach (i, c; S) {
    if (a in h && h[a] > i) l = max(l, h[a]-cast(int)i+1);
    a += c == 'A' ? +1 : -1;
  }

  io.put(l);
}

auto io = IO!()();
import lib.io;
