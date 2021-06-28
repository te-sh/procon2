---
title: "ABC #145 D"
problem: https://atcoder.jp/contests/abc145/tasks/abc145_d
---
マス $$ (i+1, j+2) $$ に移動させる回数を $$ x $$ 回, マス $$ (i+2, j+2) $$ に移動させる回数を $$ y $$ 回とすると,

$$
\begin{align}
x + 2y &= X \\
2x + y &= Y
\end{align}
$$

となるので, これを解いて,

$$
\begin{align}
x &= \frac{2Y-X}{3} \\
y &= \frac{2X-Y}{3}
\end{align}
$$

$$ x, y $$ は非負整数でなければならないので, $$ 2Y-X \equiv 2X-Y \equiv 0 \pmod 3 $$, $$ 2Y-X \geq 0 $$, $$ 2X-Y \geq 0 $$ でなければならない. そうでなければ移動させる方法は $$ 0 $$ 通りである.

$$ x, y $$ が求まるなら, 移動させる方法は $$ \combi{x+y}{x} $$ 通りである.
