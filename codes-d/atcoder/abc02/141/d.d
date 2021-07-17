// URL: https://atcoder.jp/contests/abc141/tasks/abc141_d

import std;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  int[] A; io.getA(N, A);

  auto h = A.heapify;
  foreach (_; 0..M)
    h.replaceFront(h.front/2);

  io.put(h.map!(to!long).sum);
}

auto io = IO!()();
import lib.io;
