---
title: "Educational DP Contest Q"
problem: https://atcoder.jp/contests/dp/tasks/dp_q
---
前から順に見て行く. 高さ $$ h_i $$ の木が部分列の最後の木になるときの最大の美しさを $$ B(h_i) $$ とすると, これは

$$
B(h_i) = \max_{h_j \lt h_i} B(h_j) + a_i
$$

となる. これをセグメントツリーで管理する.

計算量は $$ O(N \log N) $$ である.
