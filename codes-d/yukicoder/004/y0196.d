// URL: https://yukicoder.me/problems/no/196

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, K; io.getV(N, K);

  auto g = Graph(N);
  foreach (_; 0..N-1) {
    int a, b; io.getV(a, b);
    g.addEdgeB(a, b);
  }
  auto t = g.tree(0);

  auto c = new mint[][](N);
  foreach_reverse (u; t.dfsOrder) {
    auto children = t.children(u).array, nv = children.length;
    auto ss = 0, dp = new mint[][](nv+1); dp[0] = [mint(1)];
    foreach (i, v; children) {
      auto s = t.size[v], pss = ss; ss += s;
      dp[i+1] = new mint[](ss+1);
      foreach (j; 0..ss+1)
        foreach (k; max(0, j-pss)..min(s, j)+1)
          dp[i+1][j] += dp[i][j-k] * c[v][k];
    }
    c[u] = dp[$-1];
    c[u] ~= mint(1);
  }

  io.put(c[0][K]);
}

import lib.graph.graph;

import lib.graph.tree;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
