---
title: "ARC #059 E"
problem: https://atcoder.jp/contests/arc059/tasks/arc059_c
---
$$ A_i = B_i $$ のときを考える.

$$ c $$ 個のキャンディを使ったときの活発度を $$ f_c(x_1, x_2, \dots, x_N) $$ とすると,

$$
\begin{align}
f_c(x_1) &= x_1^c \\
f_c(x_1, x_2, \dots, x_n) &= \sum_{k=0}^c x_n^k f_{c-k}(x_1, x_2, \dots, x_{n-1})
\end{align}
$$

となるので, これを DP で解くことで部分点がもらえる. 計算量は $$ O(NC^2) $$ である.

次に $$ A_i \lt B_i $$ のときを考える.

$$
g(n, c) = \sum_{x_1=A_1}^{B_1} \sum_{x_2=A_2}^{B_2} \cdots \sum_{x_n=A_n}^{B_n} f_c(x_1, x_2, \dots, x_n)
$$

とおくと,

$$
\begin{align}
g(n, c) &= \sum_{x_1=A_1}^{B_1} \sum_{x_2=A_2}^{B_2} \cdots \sum_{x_n=A_n}^{B_n} f_c(x_1, x_2, \dots, x_n) \\
        &= \sum_{x_1=A_1}^{B_1} \sum_{x_2=A_2}^{B_2} \cdots \sum_{x_n=A_n}^{B_n} \sum_{k=0}^c x_n^k f_{c-k}(x_1, x_2, \dots, x_{n-1}) \\
        &= \sum_{x_n=A_n}^{B_n} \sum_{k=0}^c \left( x^k \sum_{x_1=A_1}^{B_1} \sum_{x_2=A_2}^{B_2} \cdots \sum_{x_{n-1}=A_{n-1}}^{B_{n-1}} f_{c-k}(x_1, x_2, \dots, x_{n-1}) \right) \\
        &= \sum_{x_n=A_n}^{B_n} \sum_{k=0}^c x^k g(n-1, c-k) \\
        &= \sum_{k=0}^c \left( g(n-1, c-k) \sum_{x_n=A_n}^{B_n} x_n^k \right)
\end{align}
$$

となる.

$$
S(n, k) = \sum_{m=1}^{n} m^k
$$

をあらかじめ計算しておけば

$$
\sum_{x_n=A_n}^{B_n} x_n^k = S(B_n, k) - S(A_n-1, k)
$$

の部分は $$ O(1) $$ で計算できるので, 全体ではやはり $$ O(NC^2) $$ で計算できる.
