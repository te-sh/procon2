// URL: https://yukicoder.me/problems/no/160

import std.algorithm, std.array, std.bitmanip, std.container, std.conv, std.format,
       std.functional, std.math, std.range, std.traits, std.typecons, std.stdio, std.string;

version(unittest) {} else
void main()
{
  int N, M, S, G; io.getV(N, M, S, G);

  auto g = GraphW!int(N);
  foreach (_; 0..M) {
    int a, b, c; io.getV(a, b, c);
    g.addEdgeB(a, b, c);
  }

  auto d = g.dijkstra(G).dist;

  auto r = [S], t = 0;
  while (r.back != G) {
    auto nt = t, nv = N;
    foreach (e; g[r.back]) {
      if (t+e.wt+d[e.dst] != d[S]) continue;
      if (e.dst < nv) {
        nt = e.wt;
        nv = e.dst;
      }
    }
    t += nt;
    r ~= nv;
  }

  io.put(r);
}

import lib.graph.graph;

import lib.graph.dijkstra;

auto io = IO!()();
import lib.io;
