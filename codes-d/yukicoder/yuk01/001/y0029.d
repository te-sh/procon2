// URL: https://yukicoder.me/problems/no/29

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto ne = 10, e = new int[](ne);
  foreach (_; 0..N) {
    int a, b, c; io.getV(a, b, c); --a; --b; --c;
    ++e[a]; ++e[b]; ++e[c];
  }

  auto r = 0;
  foreach (i; 0..ne) {
    auto rp = e[i]/2;
    e[i] -= rp*2;
    r += rp;
  }

  r += e.sum/4;
  io.put(r);
}

auto io = IO!()();
import lib.io;
