// URL: https://yukicoder.me/problems/no/9

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] A; io.getA(N, A);
  int[] B; io.getA(N, B); B[] /= 2;

  struct M { int lv, c; }

  auto fight(R)(R b)
  {
    auto m = heapify!"a.lv==b.lv ? a.c>b.c : a.lv>b.lv"(A.map!(Ai => M(Ai, 0)).array);
    foreach (bi; b) {
      auto mi = m.front;
      m.replaceFront(M(mi.lv+bi, mi.c+1));
    }
    return m.map!"a.c".maxElement;
  }

  io.put(N.iota.map!(i => fight(B.cycle.drop(i).take(N))).minElement);
}

auto io = IO!()();
import lib.io;
