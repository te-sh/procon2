---
title: "ABC #147 D"
problem: https://atcoder.jp/contests/abc147/tasks/abc147_d
---
ビットごとに考える.

$$ A_i $$ の第 $$ k $$ ビットが $$ 0 $$ である個数と $$ 1 $$ である個数をそれぞれ $$ a_k, b_k $$ とすると, $$ A_i \ \rm{XOR} \ A_j $$ の第 $$ k $$ ビットが $$ 1 $$ になる個数は $$ a_k b_k $$ である.

よってすべての合計は,

$$
\sum_{k=0}^{60} 2^k a_k b_k
$$

となる.
