---
title: "ARC #073 D"
problem: https://atcoder.jp/contests/abc060/tasks/arc073_b
---
ナップザック問題であるが, $$ v_i, w_i $$ が大きいため, そのままでは `MLE` してしまう.

そこで, $$ w_1 \leq w_i \leq w_1 + 3 $$ を使う. $$ u_i = w_i - w_1 $$ とすると, $$ 0 \leq u_i \leq 3 $$ となる.

$$ C(i, j, k) $$ を, $$ i $$ 番目の荷物まで見たときに $$ j $$ 個の荷物があり, 入れた荷物についての $$ u_i $$ の総和が $$ k $$ であるときの最大価値を表すとする. このとき,

$$
C(i+1, j, k) = \max(C(i, j, k), C(i, j-1, k+u_i)+v_i)
$$

となる. これを DP で計算し, $$ \max\{ C(N, j, k) \ \vert \ jw_1+k \leq W \} $$ を求める.
