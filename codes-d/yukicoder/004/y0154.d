// URL: https://yukicoder.me/problems/no/154

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto calc(string s)
  {
    auto r = 0, g = 0, w = 0;
    foreach_reverse (c; s)
      switch (c) {
      case 'R':
        ++r;
        break;
      case 'G':
        if (g == r) return false;
        ++g;
        break;
      case 'W':
        if (g == 0) return false;
        if (w < g) ++w;
        break;
      default:
        assert(0);
      }

    return r == g && g == w;
  }

  foreach (_; 0..N) {
    string S; io.getV(S);
    io.putB(calc(S), "possible", "impossible");
  }
}

auto io = IO!()();
import lib.io;
