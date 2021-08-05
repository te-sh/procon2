---
title: "ABC #153 E"
problem: https://atcoder.jp/contests/abc153/tasks/abc153_e
---
モンスターの体力が $$ x $$ 減ったときに消費した魔力の最小値を $$ f(x) $$ とすると,

$$
f(x) = \min_{1 \leq i \leq N} f(x - A_i) + B_i
$$

となる. ただし $$ f(x) = 0 \ (x \leq 0) $$ である.

これを DP で計算して $$ f(H) $$ を求める.
