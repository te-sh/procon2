---
title: "ABC #137 E"
problem: https://atcoder.jp/contests/abc137/tasks/abc137_e
---
$$ i $$ 番目の辺を通ったときに得られるコインの数は実質的に $$ C_i - P $$ である. 辺の重みを $$ C_i - P $$ とする.

よって, 頂点 $$ 1 $$ から頂点 $$ N $$ までの最大の重みを求める問題となる. 辺の重みの正負を逆にすれば最小の重みを求める問題となり, Bellman-Ford 法が使える.
