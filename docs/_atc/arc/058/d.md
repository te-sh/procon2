---
title: "ARC #058 D"
problem: https://atcoder.jp/contests/abc042/tasks/arc058_b
---
上から $$ i $$ 個, 左から $$ j $$ 個目のマスを $$ (i, j) $$ で表す. (0-index)

このとき, すべてのルートは必ず以下のルートのどれかになる.

$$
\begin{matrix}
(0, 0) & \rightarrow & (H-A-1, B) & \rightarrow & (H-A, B) & \rightarrow & (H-1, W-1) \\
(0, 0) & \rightarrow & (H-A-1, B+1) & \rightarrow & (H-A, B+1) & \rightarrow & (H-1, W-1) \\
& & & \vdots & & & \\
(0, 0) & \rightarrow & (H-A-1, W-1) & \rightarrow & (H-A, W-1) & \rightarrow & (H-1, W-1)
\end{matrix}
$$

ここで, 以下のルート

$$
(0, 0) \rightarrow (H-A-1, B+k) \rightarrow (H-A, B+k) \rightarrow (H-1, W-1)
$$

の組み合わせの数は,

$$
C(k) = \binom{(H-A-1)+(B+k)}{B+k} \times \binom{(A-1)+(W-1-B-k)}{W-1-B-k}
$$

となるので, 答えは

$$
\sum_{k=0}^{W-1-B} C(k)
$$

となる. 階乗と逆元はあらかじめ計算しておく.
