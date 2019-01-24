---
title: "Educational DP Contest D"
problem: https://atcoder.jp/contests/dp/tasks/dp_d
---
$$ i $$ 番目の荷物まで見たときに重量合計が $$ j $$ となるときの最大価値合計を $$ V(i, j) $$ とすると,

$$
V(i, j) = \max(V(i-1, j), V(i-1, j-w_i)+v_i)
$$

となる.

計算量は $$ O(NW) $$ である.
