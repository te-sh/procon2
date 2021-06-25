// URL: https://atcoder.jp/contests/abc143/tasks/abc143_e

import std;

version(unittest) {} else
void main()
{
  int N, M, L; io.getV(N, M, L);

  auto g = GraphM!(long, 10L^^18).init(N);
  foreach (_; 0..M) {
    int Ai, Bi, Ci; io.getV(Ai, Bi, Ci); --Ai; --Bi;
    g[Ai][Bi] = g[Bi][Ai] = Ci;
  }
  auto gd = g.floydWarshal.dist;

  auto h = GraphM!(int).init(N);
  foreach (i; 0..N-1)
    foreach (j; i+1..N)
      if (gd[i][j] <= L)
        h[i][j] = h[j][i] = 1;
  auto hd = h.floydWarshal.dist;

  int Q; io.getV(Q);
  foreach (_; 0..Q) {
    int si, ti; io.getV(si, ti); --si; --ti;
    io.putB(hd[si][ti] < h.inf, hd[si][ti]-1, -1);
  }
}

import lib.graph.graph;
import lib.graph.floyd_warshal;

auto io = IO!()();
import lib.io;
