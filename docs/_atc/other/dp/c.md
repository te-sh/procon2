---
title: "Educational DP Contest C"
problem: https://atcoder.jp/contests/dp/tasks/dp_c
---
$$ i $$ 日目に行動 $$ j $$ をしたときの幸福度の合計を $$ H(i, j) $$ とすると,

$$
H(i, A) = \max(H(i-1, B), H(i-1, C)) + a_i
$$

となる. $$ B, C $$ についても同様である.
