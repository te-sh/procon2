---
title: "Educational DP Contest N"
problem: https://atcoder.jp/contests/dp/tasks/dp_n
---
区間 $$ [i, j) $$ のスライムが合体したときに支払うコストの最小値を $$ C(i, j) $$ とすると,

$$
C(i, j) = \min_{i \lt k \lt j} \left( C(i, k) + C(k, j) + \sum_{k=i}^{j-1} a_k \right)
$$

となる. これをメモ化再帰で計算する. 和の部分は累積和をあらかじめ計算しておく.
