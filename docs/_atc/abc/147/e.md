---
title: "ABC #147 E"
problem: https://atcoder.jp/contests/abc147/tasks/abc147_e
---
マス $$ (i, j) $$ にたどり着いたときにそれまでの青い数字の和 - 赤い数字の和が $$ k $$ となれるかどうかを $$ T(i, j, k) $$ とする. また $$ C_{ij} = A_{ij}-B_{ij} $$ とする. このとき,

$$
T(i, j, k) = T(i-1, j, k-C_{ij}) \lor T(i-1, j, k+C_{ij}) \lor T(i, j-1, k-C_{ij}) \lor T(i, j-1, k+C_{ij})
$$

となる. $$ k $$ の範囲は $$ m = ((H-1)+(W-1)) \times 80 $$ とすると, 最大でも $$ -m \leq k \leq m $$ なので, この範囲だけチェックする.
