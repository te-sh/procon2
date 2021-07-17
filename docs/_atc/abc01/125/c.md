---
title: "ABC #125 C"
problem: https://atcoder.jp/contests/abc125/tasks/abc125_c
---
$$
B_i = \gcd(A_1, A_2, \dots, A_i) \\
C_i = \gcd(A_i, A_{i+1}, \dots, A_N)
$$

とすると, $$ A_i $$ を除いた配列の最大公約数は $$ \gcd(B_{i-1}, C_{i+1}) $$ となる.

$$
B_i = \gcd(B_{i-1}, A_i) \\
C_i = \gcd(C_{i+1}, A_i)
$$

となるので, これを事前に計算しておけばいい.
