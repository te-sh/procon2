---
title: "ABC #133 D"
problem: https://atcoder.jp/contests/abc133/tasks/abc133_d
---
山 $$ i $$ に $$ 2x_i $$ リットルの雨が降ったとすると,

$$
\begin{align}
x_1 + x_2 &= A_1 \\
x_2 + x_3 &= A_2 \\
x_3 + x_4 &= A_3 \\
&\cdots \\
x_{N-1} + x_N &= A_{N-1} \\
x_N + x_1 &= A_N
\end{align}
$$

となる. これを解くと,

$$
\begin{align}
x_2 &= A_1 - x_1 \\
x_3 &= A_2 - x_2 = A_2 - A_1 + x_1 \\
x_4 &= A_3 - x_3 = A_3 - A_2 + A_1 - x_1 \\
&\cdots \\
x_N &= A_{N-1} - x_{N-1} = A_{N-1} - A_{N-2} + A_{N-3} - A_{N-4} + \cdots - A_1 + x_1 \\
x_1 &= A_N - x_N = A_N - A_{N+1} + A_{N-2} - A_{N-3} + A_{N-4} - \cdots + A_1 - x_1
\end{align}
$$

となる. 最後の式から,

$$
x_1 = \frac{1}{2} \sum_{i=1}^N (-1)^{i+1} A_i
$$

となる. あとは芋蔓式に $$ x_2, x_3, \dots $$ を求めていく.
