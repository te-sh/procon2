---
title: "ABC #130 E"
problem: https://atcoder.jp/contests/abc130/tasks/abc130_e
---
$$ S $$ の $$ i $$ 個目, $$ T $$ の $$ j $$ 個目まで見たときに $$ S_i, T_j $$ をペアとする部分列の数を $$ A(i, j) $$ とする. $$ S_i = T_j $$ のときは

$$
A(i, j) = \sum_{k=1}^{i-1} \sum_{l=1}^{j-1} A(k, l)
$$

となる. これをこのまま計算すると間に合わないが, 二次元累積和を使って

$$
B(i, j) = \sum_{k=1}^i \sum_{l=1}^j A(i, j)
$$

とすると,

$$
\begin{align}
A(i, j) &= B(i-1, j-1) \\
B(i, j) &= B(i-1, j) + B(i, j-1) - B(i-1, j-1) + A(i, j)
\end{align}
$$

となって, これなら間に合う.
