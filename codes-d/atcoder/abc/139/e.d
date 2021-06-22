// URL: https://atcoder.jp/contests/abc139/tasks/abc139_e

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[][] A; io.getM(N, N-1, A);
  foreach (ref Ai; A) Ai[] -= 1;

  auto p = new int[][](N, N), c = 0;
  foreach (i; 0..N)
    foreach (j; 0..i)
      p[i][j] = p[j][i] = c++;

  auto ng = N*(N-1)/2;
  auto g = Graph(ng);

  foreach (i; 0..N)
    foreach (j; 0..N-2) {
      auto u = p[i][A[i][j]], v = p[i][A[i][j+1]];
      g.addEdge(u, v);
    }

  auto ts = g.topologicalSort;
  if (ts.hasCycle) io.put!"{exit: true}"(-1);

  auto l = new int[](ng);
  foreach (u; ts.nodes)
    foreach (v; g[u])
      l[v].maxU(l[u]+1);

  io.put(l.maxElement+1);
}

import lib.minmax;
import lib.graph.graph;
import lib.graph.topological_sort;

auto io = IO!()();
import lib.io;
