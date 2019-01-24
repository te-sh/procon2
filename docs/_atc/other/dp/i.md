---
title: "Educational DP Contest I"
problem: https://atcoder.jp/contests/dp/tasks/dp_i
---
$$ i $$ 枚目までのコインを振って表が $$ j $$ 枚出る確率を $$ P(i, j) $$ とすると,

$$
P(i, j) = P(i-1, j)(1-p_i) + P(i-1, j-1)p_i
$$

となる.

計算量は $$ O(N^2) $$ である.
