// URL: https://atcoder.jp/contests/abc137/tasks/abc137_d

import std;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);

  struct W { int A, B; }
  W[] w; io.getS!("A", "B")(N, w);
  w.sort!"a.A < b.A";

  auto h = heapify(Array!int()), i = 0, r = 0;
  foreach (j; 1..M+1) {
    while (i < N && w[i].A <= j)
      h.insert(w[i++].B);

    if (!h.empty) {
      r += h.front; h.removeFront();
    }
  }

  io.put(r);
}

auto io = IO!()();
import lib.io;
