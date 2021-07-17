---
title: "ABC #084 C"
problem: https://atcoder.jp/contests/abc084/tasks/abc084_c
---
愚直にシミュレートする.

駅 $$ i $$ に時刻 $$ t $$ にいるとき, 次の列車の発車時刻 $$ t_i $$ は以下のようになる.

$$
t_i =
\begin{cases}
S_i &(t \lt S_i) \\
\lceil t/F_i \rceil F_i &(t \geq S_i)
\end{cases}
$$
