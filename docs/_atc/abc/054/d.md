---
title: "ABC #054 D"
problem: https://atcoder.jp/contests/abc054/tasks/abc054_d
---
$$ i $$ 番目の薬品まで見たときにタイプAが $$ j $$ グラム, タイプBが $$ k $$ グラムだけ集めたときの最小金額を $$ D(i, j, k) $$ とする.

このとき,

$$
D(i, j, k) = \min(D(i-1, j, k), D(i-1, j-a_i, k-b_i) + c_i)
$$

となる. これをDPで計算し, タイプAとタイプBの比率が $$ M_a:M_b $$ となる部分の金額の最小値を求める.
