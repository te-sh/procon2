// URL: https://yukicoder.me/problems/no/656

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  string S; io.getV(S);
  io.put(S.map!(c => cast(int)(c-'0')).sum + S.count('0')*10);
}

auto io = IO!()();
import lib.io;
