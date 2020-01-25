// URL: https://yukicoder.me/problems/no/153

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto g = new int[](N+1);
  foreach (i; 2..N+1) {
    auto mex = new bool[](N+1);
    switch (i%2) {
    case 0: mex[0] = true; break;
    case 1: mex[g[i/2]^g[i/2+1]] = true; break;
    default: assert(0);
    }
    switch (i%3) {
    case 0: mex[g[i/3]] = true; break;
    case 1: mex[g[i/3+1]] = true; break;
    case 2: mex[g[i/3]] = true; break;
    default: assert(0);
    }
    g[i] = cast(int)mex.countUntil(false);
  }

  io.putB(g[N] == 0, "B", "A");
}

auto io = IO!()();
import lib.io;
