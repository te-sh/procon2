---
title: "ARC #043 A"
problem: https://beta.atcoder.jp/contests/arc043/tasks/arc043_a
---
$$ \{ S_i \} $$ の平均値を $$ \mu $$ とすると, $$ P\mu + Q = A $$ となればいい.

$$ \{ S_i \} $$ の最大値と最小値をそれぞれ $$ S_M, S_m $$ とすると, $$ P(S_M-S_m) = B $$ となればいい.

よって,

$$
P = \frac{B}{S_M-S_m} \\
Q = A - P\mu
$$

で解ける.

当然ながら $$ S_M = S_m $$ のときは解はない. ($$ B \geq 1 $$ なので)
