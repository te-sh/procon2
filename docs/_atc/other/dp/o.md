---
title: "Educational DP Contest O"
problem: https://atcoder.jp/contests/dp/tasks/dp_o
---
ビットDPを使う.

女性のある部分集合を $$ B = \{ b_1, b_2, \dots, b_n $$ として,男性の先頭 $$ n $$ 人と $$ B $$ とのマッチングの数を $$ C(B) $$ とする. これを計算するには, 男性 $$ n $$ 番目に対する女性を仮定して足し合わせればいい. 数式で書くと,

$$
C(B) = \sum_{i=1}^n C(B \setminus b_k)a_{n, b_k}
$$

となる. 集合はビットで表す.
