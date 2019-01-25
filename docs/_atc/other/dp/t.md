---
title: "Educational DP Contest T"
problem: https://atcoder.jp/contests/dp/tasks/dp_t
---
数列を $$ i $$ 番目まで見たときに, $$ i+1 $$ 番目に置ける数値 (条件は関係なく) で $$ i $$ 番目の数値より大きい数の個数が $$ j $$ 個であるときの組み合わせの数を $$ C(i, j) $$ とする.

このとき, $$ s_i $$ が `<` のときは,

$$
C(i+1, j) = \sum_{k=j+1}^{N-i} C(i, k)
$$

$$ s_i $$ が `>` のときは,

$$
C(i+1, j) = \sum_{k=0}^{j} C(i, k)
$$

となる. 和の部分は累積和をあらかじめ計算しておく.

計算量は $$ O(N^2) $$ である.
