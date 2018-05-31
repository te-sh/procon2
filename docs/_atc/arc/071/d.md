---
title: "ARC #071 D"
problem: https://beta.atcoder.jp/contests/abc058/tasks/arc071_b
---
面積は以下のようになる.

$$
\begin{align}
S &= \sum_{i=1}^{n-1}\sum_{j=1+1}^n\sum_{k=1}^{m-1}\sum_{l=k+1}^m (x_j-x_i)(y_l-y_k) \\
  &= \left( \sum_{i=1}^{n-1}\sum_{j=1+1}^n(x_j-x_i) \right) \left( \sum_{i=1}^{m-1}\sum_{j=1+1}^m(y_j-y_i) \right)
\end{align}
$$

よって, 縦横は別々に計算すればいい.

ここで,

$$
S_x(i) = \sum_{i=1}^{n-1}\sum_{j=1+1}^n(x_j-x_i)
$$

とおくと,

$$
\begin{align}
S_x(i) &= S_x(i-1) + (x_i-x_1) + (x_i-x_2) + \dots + (x_i - x_{i-1}) \\
       &= S_x(i-1) + (i-1)x_i - \sum_{j=1}^{i-1}x_j
\end{align}
$$

となり, $$ x_i $$ の累積和はあらかじめ計算しておけば $$ O(n) $$ で計算できる.

$$ S_y(i) $$ も同様に計算し, $$ S = S_x(n)S_y(m) $$ を計算する.
