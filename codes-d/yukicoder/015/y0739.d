// URL: https://yukicoder.me/problems/no/739

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  auto n = S.length;
  io.putB(n%2 == 0 && S[0..n/2] == S[n/2..$], "YES", "NO");
}

auto io = IO!()();
import lib.io;
