// URL: https://yukicoder.me/problems/no/729

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  dchar[] S; io.getV(S);
  int i, j; io.getV(i, j);

  swap(S[i], S[j]);
  io.put(S);
}

auto io = IO!()();
import lib.io;
