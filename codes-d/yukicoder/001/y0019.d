// URL: https://yukicoder.me/problems/no/19

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);
  int[] L, S; io.getC(N, L, S); L[] *= 2; --S[];

  auto uf = new UnionFind(N);
  foreach (i, Si; S) uf.unite(cast(int)i, Si);

  auto groups = uf.groups, r = 0;
  foreach (group; uf.groups) {
    auto za = new Zaatsu!int(group);
    auto g = Graph(cast(int)group.length);
    foreach (u; group)
      g.addEdge(za.comp(S[u]), za.comp(u));

    auto scc = g.stronglyConnectedComponentsKosaraju.comps;
    r += L.indexed(group).sum/2 + L.indexed(za.uncomp(scc[0])).minElement/2;
  }

  io.put(cast(double)r/2);
}

import lib.data_structure.union_find;

import lib.data_structure.zaatsu;

import lib.graph.graph;

import lib.graph.strongly_connected_components;

auto io = IO!("%.1f")();
import lib.io;
