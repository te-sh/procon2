---
title: "Div.2 #475 C"
problem: http://codeforces.com/contest/964/problem/C
---
$$ k $$ 個ごとに考える.

$$
t_m = \sum_{i=mk}^{(m+1)k-1} s_ia^{n-i}b^i
$$

とすると,

$$
\begin{align}
t_m &= \sum_{i=0}^{k-1} s_ia^{n-i-mk}b^{i+mk} \\
    &= t_0 \left(\frac{b}{a}\right)^{mk} \\
    &= t_0 c^m
\end{align}
$$

となる. ただし, $$ c = (b/a)^k $$ である.

$$ M = (n+1)/k $$ とすると, すべての和 $$ T $$ は

$$
\begin{align}
T &= \sum_{m=0}^{M-1} t_m \\
  &= \sum_{m=0}^{M-1} t_0 c^m \\
  &= t_0 \frac{c^M-1}{c-1}
\end{align}
$$

となる. $$ t_0 $$ は愚直に計算し, 階乗は繰り返し2乗法を用いる.

なお, $$ c=1 $$ のときは特別扱いで, $$ t_m = t_0 $$ であるので,

$$
T = Mt_0
$$

となる.

$$ 10^9+9 $$ は素数なので逆元も使える.
