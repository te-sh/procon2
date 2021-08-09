// URL: https://yukicoder.me/problems/no/717

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  string S; io.getV(S);
  string T; io.getV(T);

  io.put(min(S.count('A'), T.count('A')) + min(S.count('B'), T.count('B')));
}

auto io = IO!()();
import lib.io;
