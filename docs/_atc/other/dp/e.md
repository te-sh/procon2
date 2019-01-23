---
title: "Educational DP Contest E"
problem: https://atcoder.jp/contests/dp/tasks/dp_e
---
$$ i $$ 番目の荷物まで見たときに価値合計が $$ j $$ になる最小重量を $$ W(i, j) $$ とすると,

$$
W(i, j) = min(W(i-1, j), W(i-1, j-v[i]) + w_i)
$$

となる.
