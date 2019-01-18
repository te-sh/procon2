---
title: "ARC #034 C"
problem: https://atcoder.jp/contests/arc034/tasks/arc034_3
---
$$ A! = A(A-1)\cdots(B+1)B! $$ であり, $$ B! $$ の倍数は $$ kB! $$ と表せるので, これが $$ A! $$ の約数になるためには $$ k $$ が $$ A(A-1)\cdots(B+1) $$ の約数であればいい.

$$ A, A-1, \dots, B+1 $$ をそれぞれ素因数分解して $$ A(A-1)\cdots(B+1) = p_1^{q_1}p_2^{q_2}\cdots p_i^{q_i} $$ の形式に変換すれば, 約数の個数は $$ (q_1+1)(q_2+1)\cdots(q_i+1) $$ となる.
