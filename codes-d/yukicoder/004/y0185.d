// URL: https://yukicoder.me/problems/no/185

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] X, Y; io.getC(N, X, Y);

  auto r = Y[0]-X[0];
  if (r <= 0) io.put!"{exit: true}"(-1);

  io.putB(iota(1, N).map!(i => Y[i]-X[i]).all!(ri => ri == r), r, -1);
}

auto io = IO!()();
import lib.io;
