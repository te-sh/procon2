---
title: "ARC #085 C"
problem: https://atcoder.jp/contests/abc078/tasks/arc085_a
---
1回の提出でテストの実行が終わるまでの時間は $$ t = 1900M + 100(N-M) $$ である. またこのテストがすべて正解にならない確率は, $$ p = 1-(1/2)^M $$ である.

このとき, すべて正解するまでにかかる時間は,

$$
\begin{align}
T &= t(1-p) + 2t(1-p)p + 3t(1-p)p^2 + \dots \\
  &= \frac{(1-p)t}{p} \sum_{k=1}^{\infty} kp^k \\
  &= \frac{(1-p)t}{p} \frac{p}{(1-p)^2} \\
  &= 2^Mt
\end{align}
$$

となる.
