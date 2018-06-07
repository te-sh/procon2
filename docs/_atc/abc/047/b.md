---
title: "ABC #047 B"
problem: https://beta.atcoder.jp/contests/abc047/tasks/abc047_b
---
$$
\begin{align}
X_1 &= \{ x_i \ \vert \ a_i = 1 \} \cup \{ 0 \} \\
X_2 &= \{ x_i \ \vert \ a_i = 2 \} \cup \{ W \} \\
Y_1 &= \{ y_i \ \vert \ a_i = 3 \} \cup \{ 0 \} \\
Y_2 &= \{ y_i \ \vert \ a_i = 4 \} \cup \{ H \}
\end{align}
$$

とすると, 白い部分の面積は

$$
(\min\{X_2\} - \max\{X_1\})(\min\{Y_2\} - \max\{Y_1\})
$$

となる. ただし, $$ \min\{X_2\} - \max\{X_1\} \leq 0 $$ または $$ \min\{Y_2\} - \max\{Y_1\} \leq 0 $$ のときは面積は $$ 0 $$ である.
