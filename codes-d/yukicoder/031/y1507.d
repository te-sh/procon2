// URL: https://yukicoder.me/problems/no/1507

import std;

version(unittest) {} else
void main()
{
  int N; io.getV(N);

  auto g = Graph(N);
  foreach (_; 0..N-1) {
    int ui, vi; io.getV(ui, vi); --ui; --vi;
    g.addEdgeB(ui, vi);
  }

  auto a = SList!int(0), b = SList!int(0), visited = new bool[](N);
  visited[0] = true;
  while (!a.empty) {
    auto u = a.front; a.removeFront();
    foreach (v; g[u]) {
      if (!visited[v]) {
        a.insertFront(v);
        b.insertFront(v);
        visited[v] = true;
      }
    }
  }

  auto t = g.tree(0), c = new int[](N); c[] = 1;
  while (!b.empty) {
    auto u = b.front; b.removeFront();
    if (u != 0) c[t.parent[u]] += c[u];
  }

  auto r = mint(0);
  foreach (u; 1..N) {
    auto d1 = mint(c[0]), d2 = mint(c[u]), d3 = mint(c[0] - c[u]);
    r += (d3*(d3-1)/2 + d2*(d2-1)/2)/(d1*(d1-1)/2);
  }

  io.put(r/(N-1));
}

const mod = 998244353;
alias mint = ModInt!mod;

import lib.math.mod_int;
import lib.graph.graph;
import lib.graph.tree;

auto io = IO!()();
import lib.io;
