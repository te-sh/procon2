---
title: "ABC #100 D"
problem: https://atcoder.jp/contests/abc100/tasks/abc100_d
---
最終的に綺麗さとおいしさが正、人気度が負になると仮定すると, 綺麗さ+おいしさ-人気度が最大になるようにすればいい.

$$ i $$ 番目まで見た時に $$ j $$ 個選んだときの上記の値の最大値を $$ A(i, j) $$ とすると,

$$
C(i, j) = \max(C(i-1, j), C(i-1, j-1)+x_i+y_i-z_i)
$$

となるので, これをDPで計算する.

これを綺麗さ, おいしさ, 人気度の正負すべてのパターンで試せばいい.