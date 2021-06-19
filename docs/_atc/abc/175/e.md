---
title: "ABC #175 E"
problem: https://atcoder.jp/contests/abc175/tasks/abc175_e
---
マス $$ (i, j) $$ においてあるアイテムの価値を $$ V(i, j) $$ (アイテムが置いてない場合は $$ 0 $$), マス $$ (i, j) $$ に到達したときに $$ i $$ 行目のアイテムを $$ k $$ 個取ったときの価値の最大値を $$ S(i, j, k) $$ とすると,

$$
\begin{align}
S(i, j, 0) &= \max \{ S(i-1, j, k), S(i, j-1, 0) \} \\
S(i, j, 1) &= \max \{ S(i-1, j, k)+V(i, j), S(i, j-1, 0)+V(i, j), S(i, j-1, 1) \} \\
S(i, j, 2) &= \max \{ S(i, j-1, 1)+V(i, j), S(i, j-1, 2) \} \\
S(i, j, 3) &= \max \{ S(i, j-1, 2)+V(i, j), S(i, j-1, 3) \}
\end{align}
$$

となる. これを DP で計算する.
