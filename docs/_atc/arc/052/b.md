---
title: "ARC #052 B"
problem: https://beta.atcoder.jp/contests/arc052/tasks/arc052_b
---
区間 $$ [x, x+1] $$ ($$ x $$ は整数) の体積を求めて合算し, 累積和を計算しておく.

区間 $$ [x, x+1] $$ の体積は, $$ h = X_i+H_i-x $$ とすると,

$$
\begin{align}
V &= \frac{1}{3}\pi \left( \left(\frac{h}{H_i}R_i\right)^2h - \left(\frac{h-1}{H_i}R_i\right)^2(h-1) \right) \\
  &= \frac{1}{3}\pi\frac{R_i^2}{H_i^2} (3h^2-3h+1)
\end{align}
$$

となる.
