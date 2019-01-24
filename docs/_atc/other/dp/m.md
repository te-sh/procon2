---
title: "Educational DP Contest M"
problem: https://atcoder.jp/contests/dp/tasks/dp_m
---
$$ i $$ 番目の子供まで配り終わったときに配った飴の合計が $$ j $$ 個だったときの組み合わせの数を $$ C(i, j) $$ とすると,

$$
C(i, j) = \sum_{k=0}^{a_i} C(i-1, j-k)
$$

となる.

これを計算するのだが, 愚直に計算すると $$ O(K^2) $$ の計算量となるので間に合わない. そこで, 和の部分は累積和をあらかじめ計算しておくようにする.

計算量は $$ O(NK) $$ である.
