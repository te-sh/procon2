// URL: https://yukicoder.me/problems/no/758

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  if (N == 1) io.put!"{exit: true}"(1);

  auto g = Graph(N);
  foreach (_; 0..N-1) {
    int a, b; io.getV(a, b); --a; --b;
    g.addEdgeB(a, b);
  }
  auto t = g.tree(0);

  auto x = cast(int)N.iota.count!(u => t.children(u).walkLength == 0);
  auto f = Fact!mint(N-1);
  io.put(f.combi(N-1, x-1)*f.combi(N-2, x-1)/x);
}

import lib.math.fact;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

import lib.graph.graph;

import lib.graph.tree;

auto io = IO!()();
import lib.io;
