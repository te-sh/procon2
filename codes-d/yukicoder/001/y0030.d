// URL: https://ja.reactjs.org/tutorial/tutorial.html

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto g = Graph(N);
  auto p = new Vector!int[](N);
  foreach (i, ref pi; p) {
    pi = Vector!int(N);
    pi[i] = 1;
  }

  int M; io.getV(M);
  foreach (_; 0..M) {
    int P, Q, R; io.getV(P, Q, R); --P, --R;
    g.addEdge(R, P);
    p[R][R] = 0;
    p[R][P] = Q;
  }

  foreach_reverse (u; g.topologicalSort.nodes) {
    if (!g[u].empty) {
      auto q = Vector!int(N);
      foreach (v; g[u]) q += p[v]*p[u][v];
      p[u] = q;
    }
  }

  foreach (i; 0..N-1) io.put(p[N-1][i]);
}

import lib.math.matrix;

import lib.graph.graph;

import lib.graph.topological_sort;

auto io = IO!()();
import lib.io;
