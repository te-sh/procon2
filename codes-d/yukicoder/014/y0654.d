// URL: https://yukicoder.me/problems/no/654

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M, d; io.getV(N, M, d);
  int[] u, v, p, q, w; io.getC(M, u, v, p, q, w);
  u[] -= 1; v[] -= 1;

  auto dep = new int[][](N), arr = new int[][](N);
  foreach (i; 0..M) {
    dep[u[i]] ~= p[i];
    arr[v[i]] ~= q[i];
  }

  auto st = 0, tt = 10^^9;
  dep[0] ~= st;
  arr[N-1] ~= tt;

  foreach (i; 0..N) {
    dep[i] = dep[i].sort.uniq.array;
    arr[i] = arr[i].sort.uniq.array;
  }

  auto deph = new int[int][](N), arrh = new int[int][](N), c = 0;
  foreach (i; 0..N)
    foreach (pi; dep[i]) deph[i][pi] = c++;
  foreach (i; 0..N)
    foreach (qi; arr[i]) arrh[i][qi] = c++;

  auto g = GraphW!(long, 10L^^18)(c);

  foreach (i; 0..M)
    g.addEdge(deph[u[i]][p[i]], arrh[v[i]][q[i]], w[i]);

  foreach (i; 0..N)
    if (!dep[i].empty)
      foreach (j; 0..dep[i].length-1)
        g.addEdge(deph[i][dep[i][j]], deph[i][dep[i][j+1]], g.inf);

  foreach (i; 0..N-1)
    foreach (qi; arr[i]) {
      auto np = dep[i].assumeSorted.upperBound(qi+d-1);
      if (!np.empty)
        g.addEdge(arrh[i][qi], deph[i][np.front], g.inf);
    }

  foreach (i; 0..arr[N-1].length-1)
    g.addEdge(arrh[N-1][arr[N-1][i]], arrh[N-1][arr[N-1][i+1]], g.inf);

  io.put(g.dinic(deph[0][st], arrh[N-1][tt]).flow);
}

import lib.graph.graph;

import lib.graph.dinic;

auto io = IO!()();
import lib.io;
