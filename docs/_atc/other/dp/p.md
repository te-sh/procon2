---
title: "Educational DP Contest P"
problem: https://atcoder.jp/contests/dp/tasks/dp_p
---
根付き木で考える. 頂点 $$ i $$ を根とする部分木の塗るパターン数で, 頂点 $$ i $$ を黒に塗る場合のパターン数を $$ B(i) $$, 頂点 $$ i $$ を白に塗る場合のパターン数を $$ W(i) $$ とする.

このとき,

$$
\begin{align}
B(i) &= \prod_{j \in C_i} W(j) \\
W(i) &= \prod_{j \in C_i} (W(j) + B(j))
\end{align}
$$

となる. ただし, $$ C_i $$ は頂点 $$ i $$ の子の集合である.

これを葉から順に計算する.
