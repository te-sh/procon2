---
title: "Educational DP Contest J"
problem: https://atcoder.jp/contests/dp/tasks/dp_j
---
$$ i $$ 個の寿司が乗っている皿の数が $$ c_i $$ のときのその後行う操作の回数の期待値を $$ E(c_3, c_2, c_1) $$ とすると,

$$
E(c_3, c_2, c_1) = \frac{c_3}{N} E(c_3-1, c_2+1, c_1) + \frac{c_2}{N} E(c_3, c_2-1, c_1+1) \frac{c_1}{N} E(c_3, c_2, c_1-1) + \frac{c_0}{N} E(c_3, c_2, c_1) + 1
$$

となる. これを解いて,

$$
\left( 1-\frac{c_0}{N} \right) E(c_3, c_2, c_1) = \frac{c_3}{N} E(c_3-1, c_2+1, c_1) + \frac{c_2}{N} E(c_3, c_2-1, c_1+1) + \frac{c_1}{N} E(c_3, c_2, c_1-1) + 1
$$

となる.

計算量は $$ O(N^3) $$ である.
