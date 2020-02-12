// URL: https://yukicoder.me/problems/no/762

import std.algorithm, std.array, std.container, std.math, std.range, std.typecons, std.string;

version(unittest) {} else
void main()
{
  int N, M; io.getV(N, M);
  string S; io.getV(S);

  auto g = Graph(N);
  foreach (_; 0..M) {
    int u, v; io.getV(u, v); --u; --v;
    g.addEdgeB(u, v);
  }

  auto p = new mint[](N), d = new mint[](N), c = new mint[](N), a = new mint[](N);

  foreach (i; 0..N)
    if (S[i] == 'P')
      p[i] = 1;

  foreach (i; 0..N)
    if (S[i] == 'P')
      foreach (j; g[i])
        if (S[j] == 'D')
          d[j] += p[i];

  foreach (i; 0..N)
    if (S[i] == 'D')
      foreach (j; g[i])
        if (S[j] == 'C')
          c[j] += d[i];

  foreach (i; 0..N)
    if (S[i] == 'C')
      foreach (j; g[i])
        if (S[j] == 'A')
          a[j] += c[i];

  io.put(a.sum);
}

import lib.graph.graph;

const mod = 10^^9+7;
alias mint = ModInt!mod;
import lib.math.mod_int;

auto io = IO!()();
import lib.io;
