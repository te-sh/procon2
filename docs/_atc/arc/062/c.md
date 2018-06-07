---
title: "ARC #062 C"
problem: https://beta.atcoder.jp/contests/abc046/tasks/arc062_a
---
$$ i $$ 回目の高橋くんと青木くんの得票数の最小値を $$ t_i, a_i $$ とする.

$$ T_i, A_i $$ は互いに素なので, $$ t_1 = T_1, a_1 = A_1 $$ である.

$$ i $$ 回目は $$ t_i = k_iT_i, a_i = k_iT_i $$ となるが, $$ t_i \geq t_{i-1}, a_i \geq t_{i-1} $$ であるので,

$$
\begin{align}
k_i &\geq \frac{t_{i-1}}{T_i} \\
k_i &\geq \frac{a_{i-1}}{A_i}
\end{align}
$$

となる. ここから $$ k_i $$ の最小値が決まる.
